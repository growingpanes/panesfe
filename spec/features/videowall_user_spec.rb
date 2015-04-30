require 'rails_helper'

describe "Display methods access control" do
  let(:user) { FactoryGirl.create(:user) }
  let(:theme_name) { Faker::Commerce.product_name }
  let(:user_slideshow) do
    FactoryGirl.create(:slideshow, 
      user: user, 
      theme: FactoryGirl.create(:theme, name: theme_name, content: "<html><body>#{theme_name}</body></html>")
    )
  end
  let(:user_foldershow) do
    FactoryGirl.create(:foldershow, 
      user: user, 
      folder_zip: File.open(Rails.root.join('seed/folder_zips/hello_world.zip'))
    )
  end
      
  context 'with no presentations' do
    it 'should not display an error getting next' do
      expect {visit(next_presentations_path)}.not_to raise_error
      expect(page).not_to have_content 'wrong'
    end
  end

  context 'when videowall authenticated' do
    it "should display a slideshow" do
      visit_expect(display_presentation_path(user_slideshow))
      expect(page).to have_content theme_name
    end

    it "should display a foldershow" do
      visit(display_presentation_path(user_foldershow))
      expect(current_path).to eq display_presentation_path_path(user_foldershow, 'index.html')
      expect(page).to have_content 'Hello, world!'
    end

    it "should display a foldershow subpath" do
      visit_expect display_presentation_path_path(user_foldershow, 'css/bootstrap.min.css')
      expect(page).to have_content 'Bootstrap v3.3.4 (http://getbootstrap.com)'
    end

    it "should display a foldershow javascript subpath" do
      visit_expect display_presentation_path_path(user_foldershow, 'js/hello.js')
      expect(page).to have_content 'var foo'
    end

    it "should display 404 for nonexistant foldershow subpath" do
      visit_expect display_presentation_path_path(user_foldershow, 'adfgjkdfgjkhasdfg')
      expect(page).to have_content 'The page you requested could not be found.'
    end
  end

  context 'when not videowall authenticated' do
    it "should not allow completely unauthenticated user to display presentation" do
      skip "Need to revisit access control for 'display' methods"
      visit_expect(display_presentation_path(user_slideshow))
      expect(page).to have_content "You need to log in"
    end

    it "should not allow regular user to display presentation" do
      skip "Need to revisit access control for 'display' methods"
      log_in_as(user)
      visit_expect(display_presentation_path(user_slideshow))
      expect(page).to have_content I18n.t('controllers.auth.not_authorized')
    end
  end


end
