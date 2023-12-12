require 'rails_helper'

RSpec.describe "User login" do
  it "logins user" do
    @user1 = User.create(name: "CandyLand", email: "Bungie123@gmail.com", username: "funbucket1", password: "test")
    user = User.create(name: "Nate", username: "funbucket13", password: "test", email: "email@email.com")

    visit "/"
    expect(page).to_not have_content("Existing Users")
    expect(page).to_not have_content("Bungie123@gmail.com")

    click_on "I already have an account"

    expect(current_path).to eq(login_path)

    fill_in :username, with: user.username
    fill_in :password, with: user.password

    click_on "Log In"

    expect(page).to have_content("Welcome, #{user.username}!")
    
    expect(page).to have_link "Log Out"
    expect(page).to_not have_link "I already have an account"
    expect(page).to have_content("Existing Users")
    expect(page).to have_content("Bungie123@gmail.com")
  end
end