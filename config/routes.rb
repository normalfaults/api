Rails.application.routes.draw do

  # Docs
  apipie unless 'production' == Rails.env

  # Auth
  devise_for :staff, controllers: { sessions: 'sessions' }

  # Approvals
  resources :staff, defaults: { format: :json }, only: [:index, :show, :create, :update, :destroy] do
    member do
      get :projects, to: 'staff#projects', as: :projects_for
      match 'projects/:project_id' => 'staff#add_project', :via => :post, as: :add_project_to
      match 'projects/:project_id' => 'staff#remove_project', :via => :delete, as: :remove_project_from
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
      match 'staff/:staff_id' => 'projects#add_staff', :via => :post, as: :add_staff_to
      match 'staff/:staff_id' => 'projects#remove_staff', :via => :delete, as: :remove_staff_from
    end
  end

  # ProjectQuestion Routes
  resources :project_questions, except: [:edit, :new], defaults: { format: :json }

  # Service Routes
  resources :service

  # Setting Routes
  resources :settings, defaults: { format: :json }, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  # Automate Routes
  get 'automate/catalog_item_initialization', to: 'automate#catalog_item_initialization'
  get 'automate/update_servicemix_and_chef', to: 'automate#update_servicemix_and_chef'

  root 'welcome#index'
end
