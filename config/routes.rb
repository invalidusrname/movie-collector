ActionController::Routing::Routes.draw do |map|

  map.root :controller => 'home'

  map.resources :movies
  map.resources :users_movies, :collection => {:recently_added => :get}, :member => {:add_rating => :post}

  map.login  '/login',  :controller => 'Sessions', :action => 'new'
  map.logout '/logout', :controller => 'Sessions', :action => 'destroy'
  map.signup '/signup', :controller => 'Clearance::Users', :action => 'new'
  map.forgot_password '/forgot_password', :controller => 'Clearance::Passwords', :action => 'new'

  map.resource :session, :member => { :facebook_new => :get, :facebook_create => :get }

  map.box_office '/box_office', :controller => 'BoxOfficeFilms'
  map.my_movies '/my_movies', :controller => 'UsersMovies'
  map.friends_movies '/friends_movies', :controller => 'UsersMovies', :action => 'friends'

  map.facebook_post_install '/facebook_welcome', :controller => 'Home'
  map.oauth_callback '/oauth_callback', :controller => 'sessions', :action => 'oauth_callback'
  map.twitter_oauth '/oauth/twitter/sign_in', :controller => 'sessions', :action => 'twitter_new'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
