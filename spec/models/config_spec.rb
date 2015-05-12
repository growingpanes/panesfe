require 'rails_helper'

describe GrowingPanes do
  after :each do
    GrowingPanes.reload_config
  end

  it "should initialize" do
    expect{GrowingPanes.config['user']['upload_root_dir']}.not_to raise_error
  end

  it "should expand upload path" do
    expect(GrowingPanes.config['user']['upload_root_dir']).to match(Rails.root.to_s)
  end

  it "should affect the upload path seen by ImageUploader" do
    GrowingPanes.config['user']['upload_root_dir'] = '/whackyvalue'
    slide = FactoryGirl.build_stubbed(:slide)
    i = ImageUploader.new(slide)
    expect(i.store_dir).to eq "/whackyvalue/#{Rails.env}/user_#{slide.user.id}/#{slide.id}"
    expect{ImageUploader.store_dir}.to raise_error
  end

end
