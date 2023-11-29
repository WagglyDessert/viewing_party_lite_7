require "rails_helper"

RSpec.describe "Movies" do
  before :each do
    test_data 
  end

  it "A user's show page has button to discover movies, links to an index of all movies" do
    visit "/users/#{@user1.id}"

    click_button "Discover Movies"
    expect(current_path).to eq("/users/#{@user1.id}/discover")
  end
end