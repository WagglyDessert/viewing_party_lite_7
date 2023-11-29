class Movie < ApplicationRecord
  has_many :party_movies
  has_many :parties, through: :party_movies
  validates :title, presence: true
  validates :runtime, presence: true

  def self.top_movies
    conn = Faraday.new(url: "https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=1") do |faraday|
      faraday.headers["Authorization"] = Rails.application.credentials.tmdb[:key]
    end
    
    response = conn.get
    data = JSON.parse(response.body, symbolize_names: true)
    movies = Hash.new
    data[:results].each do |movie|
      movies[movie[:title]] = movie[:vote_average].round(1)
    end
    require 'pry'; binding.pry
  end

end