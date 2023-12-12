require 'rails_helper'

RSpec.describe "User login" do
  it "logins user" do
    user = User.create(name: "Nate", username: "funbucket13", password: "test", email: "email@email.com")

    visit "/"
    click_on "I already have an account"

    expect(current_path).to eq(login_path)

    fill_in :username, with: user.username
    fill_in :password, with: user.password

    click_on "Log In"

    expect(page).to have_content("Welcome, #{user.username}!")
    
    expect(page).to have_link "Log Out"
    expect(page).to_not have_link "I already have an account"
  end

  it "logs out a user" do
    user = User.create(name: "Nate", username: "funbucket13", password: "test", email: "email@email.com")
    visit "/"
    click_on "I already have an account"
    expect(current_path).to eq(login_path)
    fill_in :username, with: user.username
    fill_in :password, with: user.password
    click_on "Log In"
    expect(page).to have_content("Welcome, #{user.username}!")
    expect(page).to have_link "Log Out"
    expect(page).to_not have_link "I already have an account"

    click_link "Log Out"
    expect(current_path).to eq("/")
    expect(page).to_not have_link "Log Out"
    expect(page).to have_link "I already have an account"
  end
end