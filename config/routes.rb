Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

resources :users

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

match 'todos/index' => 'todos#index', :via => [:get], :as => :index

match 'todos/add' => 'todos#add', :via => :post

match 'todos/delete/:id' => 'todos#delete', :via => [:get], :as => :delete

match 'todos/complete' => 'todos#complete', :via => :post

match 'todos/details/:id' => 'todos#details', :via => [:get], :as => :details

patch 'todos/updatetodo/' => 'todos#updatetodo', :via => :post

match '/login' => 'sessions#new', :via => [:get], :as => :login

post '/login' => 'sessions#create', :via => :post

match '/logout' => 'sessions#destroy', :via => [:get], :as => :logout

match '/users/new' => 'users#new', :via => [:get], :as => :signmeup

match 'projects/index' => 'projects#index', :via => [:get], :as => :projects

match 'projects/add' => 'todos#add', :via => :post

match 'projects/details/:project' => 'projects#projectdetails', :via => [:get], :as => :projectdetails

match 'admin/index' => 'admin#index', :via => [:get], :as => :useradmin

patch 'admin/updateuser/' => 'admin#updateuser', :via => :post

end
