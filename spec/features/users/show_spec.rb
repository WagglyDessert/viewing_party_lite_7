require "rails_helper"

RSpec.describe "Show" do
  before :each do
    test_data 
  end

  it "A user's show page should show the user's name, a button to discover movie, and a list of viewing parties", :vcr do
    @movie1 = Movie.create(id: 2, title: "Ariel", runtime: 73, tmdb_id: 2)
    @movie2 = Movie.create(id: 3, title: "Shadows in Paradise", runtime: 74, tmdb_id: 3)
    @movie3 = Movie.create(id: 5, title: "Four Rooms ", runtime: 98, tmdb_id: 5)

    @party1 = Party.create(duration: 200, name: "Ariel", date: "January 1, 2024", start_time: "6:00 pm", movie_id: @movie1.id)
    @party2 = Party.create(duration: 100, name: "Shadows in Paradise", date: "October 2, 2025", start_time: "2:00 pm", movie_id: @movie2.id)
    @party3 = Party.create(duration: 98, name: "Four Rooms ", date: "July 15, 2026", start_time: "5:00 pm", movie_id: @movie3.id)

    @userparty1 = UserParty.create(user_id: @user1.id, party_id: @party1.id, creator: true)
    @userparty2 = UserParty.create(user_id: @user2.id, party_id: @party1.id, creator: false)

    visit "/"
    click_on "I already have an account"
    fill_in :username, with: @user1.username
    fill_in :password, with: @user1.password
    click_on "Log In"
    visit "/users/#{@user1.id}"

    expect(page).to have_content("#{@user1.name}'s Dashboard")
    expect(page).to have_content("Viewing Parties")
    expect(page).to have_content("Ariel")
    expect(page).to_not have_content("Shadows in Paradise")
    expect(page).to_not have_content("Four Rooms")
    
    click_button "Discover Movies"
    expect(current_path).to eq("/users/#{@user1.id}/discover")
    
    visit "/"
    click_link "Log Out"
    click_on "I already have an account"
    fill_in :username, with: @user2.username
    fill_in :password, with: @user3.password
    click_on "Log In"

    visit "/users/#{@user2.id}"

    expect(page).to have_content("#{@user2.name}'s Dashboard")
  end

end