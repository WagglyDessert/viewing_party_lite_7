require "rails_helper"

RSpec.describe "Root" do
  before :each do
    test_data 
  end

  describe "When a user visits the root path they should be on the landing page ('/')" do
    it "includes title of application" do
      visit "/"
      expect(page).to have_content("Viewing Party Lite")
    end

    it "has button to create a new user" do
      visit "/"
      click_button("Create New User")
      expect(current_path).to eq("/register")
    end

    it "has list of existing users which links to user dashboard" do
      visit "/"
      visit "/register"
    
      name = "Jiggy"
      email = "email@email.com"
      username = "funbucket13"
      password = "test"
      password_confirmation = "test"

      fill_in :user_name, with: name
      fill_in :user_email, with: email
      fill_in :user_username, with: username
      fill_in :user_password, with: password
      fill_in :user_password_confirmation, with: password_confirmation

      click_on "Create New User"
      click_link "Home"
      
      expect(page).to have_content("Existing Users")
      expect(page).to have_content("email@email.com")
    end

    it "has link to go to landing page" do
      visit "/"
      click_link("Home")
      expect(current_path).to eq("/")
    end
  end
end