require "rails_helper"

describe "Admin login" do
  describe "happy path" do
    it "I can log in as an admin and get to my dashboard" do
	    admin = User.create(username: "superuser@awesome-site.com",
			    name: "Superuser",
          password: "super_secret_passw0rd", 
          email: "admin@email.com",
          role: 2)

      visit "/"
      click_on "I already have an account"
      fill_in :username, with: admin.username
      fill_in :password, with: admin.password
      click_on "Log In"

      expect(current_path).to eq(admin_dashboard_path)
    end
  end
end

describe "as default user" do
  it 'does not allow default user to see admin dashboard index' do
    user = User.create(username: "fern@gully.com",
                       password: "password",
                       email: "admin@email.com",
                       role: 0)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit admin_dashboard_path

    expect(page).to have_content("The page you were looking for doesn't exist.")
  end

  it "can see a list of all users emails which are links to their dashboards", :vcr do
    test_data
    @movie1 = Movie.create(id: 2, title: "Ariel", runtime: 73, tmdb_id: 2)
    @movie2 = Movie.create(id: 3, title: "Shadows in Paradise", runtime: 74, tmdb_id: 3)
    @movie3 = Movie.create(id: 5, title: "Four Rooms ", runtime: 98, tmdb_id: 5)

    @party1 = Party.create(duration: 200, name: "Ariel", date: "January 1, 2024", start_time: "6:00 pm", movie_id: @movie1.id)
    @party2 = Party.create(duration: 100, name: "Shadows in Paradise", date: "October 2, 2025", start_time: "2:00 pm", movie_id: @movie2.id)
    @party3 = Party.create(duration: 98, name: "Four Rooms ", date: "July 15, 2026", start_time: "5:00 pm", movie_id: @movie3.id)

    @userparty1 = UserParty.create(user_id: @user1.id, party_id: @party1.id, creator: true)
    @userparty2 = UserParty.create(user_id: @user2.id, party_id: @party1.id, creator: false)

    

    admin = User.create(username: "superuser@awesome-site.com",
        name: "Superuser",
        password: "super_secret_passw0rd", 
        email: "admin@email.com",
        role: 2)

    visit "/"
    click_on "I already have an account"
    fill_in :username, with: admin.username
    fill_in :password, with: admin.password
    click_on "Log In"

    expect(current_path).to eq(admin_dashboard_path)
    expect(page).to have_content("Existing Users")
    expect(page).to have_content("#{@user1.email}")
    expect(page).to have_content("#{@user2.email}")
    expect(page).to have_content("#{@user3.email}")

    click_link "#{@user1.email}"

    expect(page).to have_content("#{@user1.name}'s Dashboard")
    expect(page).to have_content("Viewing Parties")
    expect(page).to have_content("Ariel")
    expect(page).to_not have_content("Shadows in Paradise")
    expect(page).to_not have_content("Four Rooms")
  end
end