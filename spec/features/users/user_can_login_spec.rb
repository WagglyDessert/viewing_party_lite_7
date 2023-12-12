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
  end

  it "cannot log in with bad credentials" do
    user = User.create(name: "Nate", username: "funbucket13", password: "test", email: "email@email.com")
  
    # we don't have to go through root_path and click the "I have an account" link any more
    visit login_path
    
  
    fill_in :username, with: user.username
    fill_in :password, with: "incorrect password"
  
    click_on "Log In"
  
    expect(current_path).to eq(login_path)
  
    expect(page).to have_content("Sorry, your credentials are bad.")
  end
end