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

  match '/box_office'=> 'box_office_films#index', :as => :box_office
  match '/my_movies'=> 'users_movies#index', :as => :my_movies
  match '/friends_movies'=> 'users_movies#friends', :as => :friends_movies

  match '/facebook_welcome'=> 'home#index', :as => :facebook_post_install
  match '/oauth_callback'=> 'sessions#oauth_callback', :as => :oauth_callback
  match '/oauth/twitter/sign_in'=> 'sessions#twitter_new', :as => :twitter_oauth

  # authentication
  match '/login'  => 'sessions#new',     :as => :login
  match '/login'  => 'sessions#new',     :as => :sign_in
  match '/logout' => 'sessions#destroy', :as => :logout
  match '/signup' => 'Clearance::Users#new', :as => :signup
  match '/create_user' => 'Clearance::Users#create', :as => :create_user
  match '/forgot_password' => 'Clearance::Passwords#new', :as => :forgot_password

  root :to => "home#index"

  match ':controller(/:action(/:id(.:format)))'
end
