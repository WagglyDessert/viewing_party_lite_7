# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

@user1 = User.create(name: "CandyLand", email: "Bungie123@gmail.com", username: "funbucket1", password: "test")
@user2 = User.create(name: "Macbeth", email: "Blurp@gmail.com", username: "funbucket2", password: "test")
@user3 = User.create(name: "Jerry", email: "Moogoo@gmail.com", username: "funbucket3", password: "test")

@movie1 = Movie.create(title: "Ariel", runtime: 73, tmdb_id: 2)
@movie2 = Movie.create(title: "Shadows in Paradise", runtime: 74, tmdb_id: 3)
@movie3 = Movie.create(title: "Four Rooms ", runtime: 98, tmdb_id: 5)

@party1 = Party.create(duration: 200, name: "Ariel", date: "January 01, 2024", start_time: 1800, movie_id: @movie1.id)
@party2 = Party.create(duration: 100, name: "Shadows in Paradise", date: "October 2, 2025", start_time: 1400, movie_id: @movie2.id)
@party3 = Party.create(duration: 98, name: "Four Rooms ", date: "July 15, 2026", start_time: 1900, movie_id: @movie3.id)

@userparty1 = UserParty.create(user_id: @user1.id, party_id: @party1.id, creator: true)
@userparty2 = UserParty.create(user_id: @user2.id, party_id: @party1.id, creator: false)
