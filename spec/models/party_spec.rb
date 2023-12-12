require "rails_helper"

RSpec.describe Party, type: :model do
  
  describe "relationships" do
    it { should have_many(:user_parties) }
    it { should have_many(:users).through(:user_parties) }
    it { should belong_to(:movie) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:duration) }
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:start_time) }
  end

  describe 'format time from party model method', :vcr do
    it 'will format time from military to normie time' do
      @time = Party.formatted_time({"time(4i)" => "00", "time(5i)" => "30"})
      @time2 = Party.formatted_time({"time(4i)" => "09", "time(5i)" => "40"})
      @time3 = Party.formatted_time({"time(4i)" => "14", "time(5i)" => "50"})
      @time4 = Party.formatted_time({"time(4i)" => "12", "time(5i)" => "20"})
      expect(@time).to eq("12:30 am")
      expect(@time2).to eq("9:40 am")
      expect(@time3).to eq("2:50 pm")
      expect(@time4).to eq("12:20 pm")
    end
  end

  describe 'tell us the host', :vcr do
    it 'tell us the host' do
      @user1 = User.create(name: "CandyLand", email: "Bungie123@gmail.com", username: "funbucket1", password: "test")
      @user2 = User.create(name: "Macbeth", email: "Blurp@gmail.com", username: "funbucket2", password: "test")

      @movie1 = Movie.create_from_api(808)
      @party1 = Party.create(duration: 200, name: "Ariel", date: "January 1, 2024", start_time: "6:00 pm", movie_id: @movie1.id)

      @userparty1 = UserParty.create(user_id: @user1.id, party_id: @party1.id, creator: true)
      @userparty2 = UserParty.create(user_id: @user2.id, party_id: @party1.id, creator: false)

      expect(@party1.host(@user1.id)).to eq("Hosting")
      expect(@party1.host(@user2.id)).to eq("Invited")
    end
  end

  describe 'format date' do
    it 'will format date' do
      @date = Party.formatted_date({"day(1i)" => "2024", "day(2i)" => "1", "day(3i)" => "15"})
      expect(@date).to eq("January 15, 2024")
    end
  end

  describe 'image api call' do
    it 'will get an image url', :vcr do

      @movie1 = Movie.create_from_api(808)
      @party1 = Party.create(duration: 200, name: "Ariel", date: "January 1, 2024", start_time: "6:00 pm", movie_id: @movie1.id)

      expect(@party1.image_api_call).to eq("https://www.themoviedb.org/t/p/w600_and_h900_bestv2//dyhaB19AICF7TO7CK2aD6KfymnQ.jpg")
    end
  end
end