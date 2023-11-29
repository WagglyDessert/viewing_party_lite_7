Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get "/", to: "landing#index"

  get "/register", to: "users#new"
  post "/register", to: "users#create"
  
  get "/users/:user_id", to: "users#show"

  get "/users/:user_id/discover", to: "users/movies#discover"
  get "/users/:user_id/movies", to: "users/movies#index"
  get "/users/:user_id/movies/:movie_id", to: "users/movies#show"
end
