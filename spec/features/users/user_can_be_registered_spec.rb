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

  it "will not create new user without name" do
    visit "/register"
    
    name = ""
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

    expect(page).to have_content("Name can't be blank")
    expect(current_path).to eq("/register")
  end

  it "will not create new user without email" do
    visit "/register"
    
    name = "Jiggy"
    email = ""
    username = "funbucket13"
    password = "test"
    password_confirmation = "test"

    fill_in :user_name, with: name
    fill_in :user_email, with: email
    fill_in :user_username, with: username
    fill_in :user_password, with: password
    fill_in :user_password_confirmation, with: password_confirmation

    click_on "Create New User"

    expect(page).to have_content("Email can't be blank")
    expect(current_path).to eq("/register")
  end

  it "will not create new user without matching pw and pw-c" do
    
    visit "/register"
    
    name = "Jiggy"
    email = "email@email.com"
    username = "funbucket13"
    password = "test"
    password_confirmation = "wrong"

    fill_in :user_name, with: name
    fill_in :user_email, with: email
    fill_in :user_username, with: username
    fill_in :user_password, with: password
    fill_in :user_password_confirmation, with: password_confirmation

    click_on "Create New User"

    expect(page).to have_content("Password confirmation doesn't match Password")
    expect(current_path).to eq("/register")
  end
end