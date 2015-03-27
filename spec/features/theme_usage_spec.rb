require 'rails_helper'

describe "theme usage" do
  context "as regular user" do
    let(:user) { FactoryGirl.create(:user) }
    let(:other_user) { FactoryGirl.create(:user) }

    before :each do
      log_in_as user
      @other_theme = FactoryGirl.create(:theme, user: other_user)
    end

    it "should allow viewing own and others themes" do
      user_theme = FactoryGirl.create(:theme, user: user)
      visit(themes_path)
      expect(find('table')).to have_content user_theme.name
      expect(find('table')).to have_content @other_theme.name
    end

    it "should disallow actions on others themes" do
      visit(themes_path)
      expect(page).to have_xpath(".//table/tbody/tr", :count => 1)
      expect(find('table')).to have_content @other_theme.name
      expect(find('table')).not_to have_content I18n.t('helpers.links.edit')
      expect(find('table')).not_to have_content I18n.t('helpers.links.destroy')

      visit(edit_theme_path(@other_theme))
      expect(current_path).to eq(logged_in_home_path)
      expect(page).to have_content(I18n.t('controllers.auth.not_authorized'))
    end

    it "should let you create a presentation with a theme" do
      visit(themes_path)
      click_link I18n.t('controllers.themes.use_this_theme')
      expect(current_path).to eq(new_theme_presentation_path(@other_theme))
      name = Faker::Commerce.product_name
      fill_in 'Name', :with => name
      click_button 'Create Presentation'
      presentation  = Presentation.last
      expect(current_path).to eq(edit_presentation_path(presentation))
      expect(presentation.theme).to eq(@other_theme)
    end


  end
end