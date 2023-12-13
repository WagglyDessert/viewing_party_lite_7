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
end