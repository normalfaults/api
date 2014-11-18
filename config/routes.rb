Rails.application.routes.draw do

  unless Rails.env == 'production'
    apipie
  end

  devise_for :staff

  # Organizations
  resources :organizations, only: [:create, :update, :show, :index]

  # Dashboard Routes
  resources :dashboard

  # Manage Routes
  resources :manage

  # Marketplace Routes
  resources :marketplace

  # Project Routes
  resources :project

  # Project Routes
  resources :service

  # Setting Routes
  get '/settings' => 'setting#index'
  get '/setting/new' => 'setting#new'
  get '/setting/:id' => 'setting#show'
  post '/setting' => 'setting#create'
  get '/setting/:id/edit' => 'setting#edit'
  put '/setting/:id' => 'setting#update'
  delete '/setting/:id' => 'setting#destroy'

  # Automate Routes
  get 'automate/catalog_item_initialization', to: 'automate#catalog_item_initialization'
  get 'automate/update_servicemix_and_chef', to: 'automate#update_servicemix_and_chef'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

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
end
