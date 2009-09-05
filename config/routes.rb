ActionController::Routing::Routes.draw do |map|

  map.resources :movies
  map.resources :users_movies, :collection => {:recently_added => :get}, :member => {:add_rating => :post}

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => 'home'

  map.login  '/login',  :controller => 'Sessions', :action => 'new'
  map.logout '/logout', :controller => 'Sessions', :action => 'destroy'
  map.signup '/signup', :controller => 'Clearance::Users', :action => 'new'
  map.forgot_password '/forgot_password', :controller => 'Clearance::Passwords', :action => 'new'

  map.resource :session, :member => { :facebook_new => :get, :facebook_create => :get }

  map.box_office '/box_office', :controller => 'BoxOfficeFilms'
  map.my_movies '/my_movies', :controller => 'UsersMovies'
  map.friends_movies '/friends_movies', :controller => 'UsersMovies', :action => 'friends'

  map.namespace :admin do |admin|
    admin.resources :users
  end

  # See how all your routes lay out with "rake routes"

  map.facebook_post_install '/facebook_welcome', :controller => 'Home'
  map.oauth_callback '/oauth_callback', :controller => 'sessions', :action => 'oauth_callback'
  map.twitter_oauth '/oauth/twitter/sign_in', :controller => 'sessions', :action => 'twitter_new'

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
