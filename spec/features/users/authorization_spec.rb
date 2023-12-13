require 'rails_helper'

RSpec.describe "Authorization" do
  it "does not show a list of existing user's emails until a user has logged-in" do
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
    expect(page).to_not have_link("Bungie123@gmail.com")
  end

  it "does not show a user's dashboard until a user has logged-in" do
    visit "/"
    click_link "Dashboard"
    expect(page).to have_content("Must be logged in to view your dashboard.")
  end

  it "shows a user's dashboard after logging in" do
    user = User.create(name: "Nate", username: "funbucket13", password: "test", email: "email@email.com")
    visit "/"
    click_on "I already have an account"
    fill_in :username, with: user.username
    fill_in :password, with: user.password
    click_on "Log In"

    click_link "Dashboard"
    expect(page).to have_content("#{user.name}'s Dashboard")
    expect(page).to have_button("Discover Movies")
    expect(page).to have_content("Viewing Parties")
  end

  it "does not allow a viewing party to be created for a movie until logging in", :vcr do
    @user1 = User.create(name: "CandyLand", email: "Bungie123@gmail.com", username: "funbucket1", password: "test")
    visit "/users/#{@user1.id}/movies/808"
    click_button "Create Viewing Party for Shrek"
    expect(page).to have_content("Must be logged in to create a viewing party.")
  end

  it "allows a viewing party to be created for a movie after logging in", :vcr do
    user = User.create(name: "Nate", username: "funbucket13", password: "test", email: "email@email.com")
    visit "/"
    click_on "I already have an account"
    fill_in :username, with: user.username
    fill_in :password, with: user.password
    click_on "Log In"
    visit "/users/#{user.id}/movies/808"
    
    click_button "Create Viewing Party for Shrek"
    expect(page).to have_content("Create a Movie Party for Shrek")
    expect(page).to have_button("Discover Page")
    expect(page).to have_content("Viewing Party Details")
    expect(page).to have_content("Movie Title")
    expect(page).to have_content("Shrek")
    expect(page).to have_content("Duration of Party")
    expect(find_field(:duration).value).to eq("90")
    expect(page).to have_content("Day")
    expect(page).to have_content("Start Time")
    expect(page).to have_content("Invite Other Users")
  end
end