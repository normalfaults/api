Rails.application.routes.draw do

  #Docs
  apipie unless 'production' == Rails.env

  # Auth
  devise_for :staff, controllers: { sessions: 'sessions' }

  # Approvals
  resources :staff, defaults: { format: :json }, only: [:index, :show, :create, :update, :destroy] do
    member do
      get :projects, to: 'staff#projects', as: :projects_for
      post :projects, to: 'staff#add_project', as: :add_project_to
      delete :projects, to: 'staff#remove_project', as: :remove_project_from
    end
  end

  # Approvals
  resources :approvals, except: [:edit, :new], defaults: { format: :json }

  # Organizations
  resources :organizations, except: [:edit, :new], defaults: { format: :json }

  # Orders
  resources :orders, except: [:edit, :new], defaults: { format: :json }

  # Products
  resources :products, except: [:edit, :new], defaults: { format: :json }

  # Dashboard Routes
  resources :dashboard

  # Manage Routes
  resources :manage

  # Marketplace Routes
  resources :marketplace

  # Project Routes
  resources :projects, defaults: { format: :json }, only: [:index, :show, :create, :update, :destroy] do
    member do
      get :staff, to: 'projects#staff', as: :staff_for
      post :staff, to: 'projects#add_staff', as: :add_staff_to
      match 'staff/:staff_id' => 'projects#remove_staff', :via => :delete, as: :remove_staff_from
    end
  end

  # Project Routes
  resources :service

  # Setting Routes
  resources :settings

  # Automate Routes
  get 'automate/catalog_item_initialization', to: 'automate#catalog_item_initialization'
  get 'automate/update_servicemix_and_chef', to: 'automate#update_servicemix_and_chef'

  root 'welcome#index'
end
