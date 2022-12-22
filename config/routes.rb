# frozen_string_literal: true

Rails.application.routes.draw do
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
  get "/login", to: "sessions#new", as: "login"
  get "/logout", to: "sessions#destroy", as: "logout"
  # get "/signup", to: "Clearance::Users#new", as: "signup"
  # get "/create_user", to: "Clearance::Users#create", as: "create_user"

  # get "/forgot_password" => "clearance/passwords/new", as: "forgot_password"

  resources :passwords, controller: "clearance/passwords", only: %i[create new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "clearance/users", only: [:create] do
    resource :password,
             controller: "clearance/passwords",
             only: %i[edit update]
  end

  root "home#index"
end
