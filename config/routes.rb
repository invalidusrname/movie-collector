# TODO: fix clearance and facebook routes
MovieCollector::Application.routes.draw do
  resource :session do
    # get :facebook_new
    # get :facebook_create
  end

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

  get '/box_office' => 'box_office_films#index', :as => :box_office
  get '/my_movies' => 'users_movies#index', :as => :my_movies
  get '/friends_movies' => 'users_movies#friends', :as => :friends_movies

  get '/facebook_welcome' => 'home#index', :as => :facebook_post_install
  get '/oauth_callback' => 'sessions#oauth_callback', :as => :oauth_callback
  get '/oauth/twitter/sign_in' => 'sessions#twitter_new', :as => :twitter_oauth

  # authentication
  get '/login'  => 'sessions#new',     :as => :login
  get '/login'  => 'sessions#new',     :as => :sign_in
  get '/logout' => 'sessions#destroy', :as => :logout
  get '/signup' => 'Clearance::Users#new', :as => :signup
  get '/create_user' => 'Clearance::Users#create', :as => :create_user
  get '/forgot_password' => 'Clearance::Passwords#new', :as => :forgot_password

  root to: "home#index"

  get ':controller(/:action(/:id(.:format)))'
end
