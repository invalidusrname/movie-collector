# TODO: fix routes
ActionController::Routing::Routes.draw do |map|
  Clearance::Routes.draw(map)

  map.root :controller => 'home'

  map.resources :movies, :collection => {:amazon_search => :get}
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


# +   # first created -> highest priority.
#
# -   map.root :controller => 'home'
# +   # Sample of regular route:
# +   #   match 'products/:id' => 'catalog#view'
# +   # Keep in mind you can assign values other than :controller and :action
#
# -   map.resources :movies, :collection => {:amazon_search => :get}
# +   # Sample of named route:
# -   map.resources :users_movies, :collection => {:recently_added => :get}, :member => {:add_rating => :post}
# +   #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
# +   # This route can be invoked with purchase_url(:id => product.id)
#
# -   map.login  '/login',  :controller => 'Sessions', :action => 'new'
# +   # Sample resource route (maps HTTP verbs to controller actions automatically):
# -   map.logout '/logout', :controller => 'Sessions', :action => 'destroy'
# +   #   resources :products
# -   map.signup '/signup', :controller => 'Clearance::Users', :action => 'new'
# -   map.forgot_password '/forgot_password', :controller => 'Clearance::Passwords', :action => 'new'
#
# -   map.resource :session, :member => { :facebook_new => :get, :facebook_create => :get }
# +   # Sample resource route with options:
# +   #   resources :products do
# +   #     member do
# +   #       get :short
# +   #       post :toggle
# +   #     end
# +   #
# +   #     collection do
# +   #       get :sold
# +   #     end
# +   #   end
#
# -   map.box_office '/box_office', :controller => 'BoxOfficeFilms'
# +   # Sample resource route with sub-resources:
# -   map.my_movies '/my_movies', :controller => 'UsersMovies'
# +   #   resources :products do
# -   map.friends_movies '/friends_movies', :controller => 'UsersMovies', :action => 'friends'
# +   #     resources :comments, :sales
# +   #     resource :seller
# +   #   end
#
# -   map.facebook_post_install '/facebook_welcome', :controller => 'Home'
# +   # Sample resource route with more complex sub-resources
# -   map.oauth_callback '/oauth_callback', :controller => 'sessions', :action => 'oauth_callback'
# +   #   resources :products do
# -   map.twitter_oauth '/oauth/twitter/sign_in', :controller => 'sessions', :action => 'twitter_new'
# +   #     resources :comments
# +   #     resources :sales do
# +   #       get :recent, :on => :collection
# +   #     end
# +   #   end
#
# -   map.connect ':controller/:action/:id'
# +   # Sample resource route within a namespace:
# -   map.connect ':controller/:action/:id.:format'
# +   #   namespace :admin do
# +   #     # Directs /admin/products/* to Admin::ProductsController
# +   #     # (app/controllers/admin/products_controller.rb)
# +   #     resources :products
# +   #   end
# +
# +   # You can have the root of your site routed with "root"
# +   # just remember to delete public/index.html.
# +   # root :to => "welcome#index"
# +
# +   # See how all your routes lay out with "rake routes"
# +
# +   # This is a legacy wild controller route that's not recommended for RESTful applications.
# +   # Note: This route will make all actions in every controller accessible via GET requests.
# +   # match ':controller(/:action(/:id(.:format)))'