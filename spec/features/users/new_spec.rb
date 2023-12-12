require "rails_helper"

RSpec.describe "New" do
  before :each do
    test_data 
  end

  it "can create a new user with all attributes" do
    visit "/register"

    fill_in "Name", with: "Name"
    fill_in "email", with: "email@email.com"
  
    click_button "Create New User"

    expect(current_path).to eq("/register")
  end

  it "rejects repeat emails" do
    visit "/register"
    expect(page).to_not have_content("This email is already registered")
    name = "Nate"
    email = "email@email.com"
    username = "funbucket13"
    password = "test"
    password_confirmation = "test"

    fill_in :user_name, with: name
    fill_in :user_email, with: email
    fill_in :user_username, with: username
    fill_in :user_password, with: password
    fill_in :user_password_confirmation, with: password_confirmation

    click_button "Create New User"
    visit "/register"

    click_button "Create New User"
    fill_in :user_name, with: "Norm"
    fill_in :user_email, with: email
    fill_in :user_username, with: "Boosername"
    fill_in :user_password, with: password
    fill_in :user_password_confirmation, with: password_confirmation
    click_button "Create New User"

    expect(current_path).to eq("/register")
    expect(page).to have_content("Email has already been taken")
  end

end