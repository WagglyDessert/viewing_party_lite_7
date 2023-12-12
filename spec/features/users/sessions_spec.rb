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
    
    #check existence of session cookie
  end
end