# frozen_string_literal: true

MovieCollector::Application.routes.draw do
  resource :session

  resources :movies do
    collection do
      get :amazon_search
    end
  end

  resources :users_movies do
    collection do
      get :recently_added
    end

    member do
      post :add_rating
    end
  end

  get "/box_office", to: "box_office_films#index", as: "box_office"
  get "/my_movies", to: "users_movies#index", as: "my_movies"
  get "/friends_movies", to: "users_movies#friends", as: "friends_movies"

  # authentication
  get "/login", to: "sessions#new",     as: "login"
  get "/login", to: "sessions#new",     as: "sign_in"
  get "/logout", to: "sessions#destroy", as: "logout"
  get "/signup", to: "Clearance::Users#new", as: "signup"
  get "/create_user", to: "Clearance::Users#create", as: "create_user"
  get "/forgot_password", to: "Clearance::Passwords#new", as: "forgot_password"

  root "home#index"
end
