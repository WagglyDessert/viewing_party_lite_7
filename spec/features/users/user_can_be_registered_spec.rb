require 'rails_helper'

RSpec.describe "User registration form" do
  it "creates new user" do
    visit "/register"
    
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

   

    click_on "Create New User"

    expect(page).to have_content("Welcome, #{username}!")
  end
end