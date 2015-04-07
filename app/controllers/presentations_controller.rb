class PresentationsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:display, :next]
  before_action :api_auth!, only: [:display, :next]
  before_action :set_presentation, only: [:show, :display, :push, :edit, :update, :destroy]

  # GET /presentations
  # GET /presentations.json
  def index
    @presentations = policy_scope(Presentation)
  end

  # GET /presentations/1
  # GET /presentations/1.json
  def show
  end

  # TODO: this could be improved to better "randomize" the selection by 
  # taking recently-played information in to account.
  def next
    offset = rand(Presentation.count)
    presentation = Presentation.offset(offset).select([:id]).first
    redirect_to display_presentation_url(presentation)
  end

  def push
    begin
      Panesd.new(display_presentation_url(@presentation)).push
    rescue Errno::ECONNREFUSED
      flash[:error] = t('controllers.presentations.panesd_offline')
    end
    flash[:notice] = t('controllers.presentations.presentation_pushed')
    redirect_to action: :index
  end

  # GET /presentations/1/display
  def display
    respond_to do |format|
      format.html { render html: @presentation.theme.content.html_safe }
      format.json { render json: @presentation.slides }
    end
  end

  # GET /presentations/new
  def new
    @presentation = Presentation.new
    authorize @presentation
    @presentation.slides.build
    if params[:theme_id]
      @presentation.theme = policy_scope(Theme).find_by_id(params[:theme_id])
    end
  end

  # GET /presentations/1/edit
  def edit
    @presentation.slides.build
  end

  # POST /presentations
  # POST /presentations.json
  def create
    @presentation = Presentation.new(presentation_params)
    @presentation.user = current_user

    respond_to do |format|
      if @presentation.save
        format.html { redirect_to edit_presentation_path(@presentation), notice: t('controllers.presentations.created_flash') }
        format.json { render :show, status: :created, location: @presentation }
      else
        format.html { render :new }
        format.json { render json: @presentation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /presentations/1
  # PATCH/PUT /presentations/1.json
  def update
    respond_to do |format|
      if @presentation.update(presentation_params)
        format.html { redirect_to @presentation, notice: 'Presentation was successfully updated.' }
        format.json { render :show, status: :ok, location: @presentation }
      else
        format.html { render :edit }
        format.json { render json: @presentation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /presentations/1
  # DELETE /presentations/1.json
  def destroy
    @presentation.destroy
    respond_to do |format|
      format.html { redirect_to presentations_url, notice: 'Presentation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_presentation
      @presentation = policy_scope(Presentation).find_by_id!(params[:id])
      authorize @presentation
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def presentation_params
      params.require(:presentation).permit(:name, :published, :theme_id, slides_attributes: [:id, :image, :_destroy])
    end
end
