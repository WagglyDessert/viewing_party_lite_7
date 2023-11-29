require "rails_helper"

RSpec.describe "Movies Index" do
  before :each do
    test_data 
  end

  it "Will show the top 20 rated movies and their vote average if the Top Movies button is clicked", :vcr do
    visit "/users/#{@user1.id}/discover"

    click_button "Find Top Rated Movies"
    expect(current_path).to eq("/users/#{@user1.id}/movies")

    expect("The Godfather").to appear_before("The Shawshank Redemption")
    expect("The Godfather").to appear_before("Vote Average: 8.7")
    expect("Vote Average: 8.7").to appear_before("The Shawshank Redemption")
    expect("The Shawshank Redemption").to appear_before("Seven Samurai")
    expect("Vote Average: 8.5").to appear_before("Cinema Paradiso")
    expect("Seven Samurai").to appear_before("Cinema Paradiso")

  end


end