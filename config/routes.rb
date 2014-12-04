Rails.application.routes.draw do
  # Docs
  apipie

  # Auth
  devise_for :staff, controllers: { sessions: 'sessions' }

  # Alerts Routes
  match 'alerts/all' => 'alerts#show_all', :via => :get, defaults: { format: :json }
  match 'alerts/active' => 'alerts#show_active', :via => :get, defaults: { format: :json }
  match 'alerts/inactive' => 'alerts#show_inactive', :via => :get, defaults: { format: :json }
  resources :alerts, defaults: { format: :json }

  # User Setting Options Routes
  resources :user_setting_options, defaults: { format: :json }

  # Approvals
  resources :staff, defaults: { format: :json }, only: [:index, :show, :create, :update, :destroy] do
    collection do
      match 'current_member' => 'staff#current_member', via: :get, defaults: { format: :json }
    end

    member do
      match 'settings' => 'staff#user_settings', :via => :get, as: :user_settings_for
      match 'settings' => 'staff#add_user_setting', :via => :post, as: :add_user_setting_to
      match 'settings/:user_setting_id' => 'staff#show_user_setting', :via => :get
      match 'settings/:user_setting_id' => 'staff#update_user_setting', :via => :put
      match 'settings/:user_setting_id' => 'staff#remove_user_setting', :via => :delete, as: :remove_user_setting_from
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

  # Chargebacks
  resources :chargebacks, except: [:edit, :new], defaults: { format: :json }

  # Clouds
  resources :clouds, except: [:edit, :new], defaults: { format: :json }

  # Project Routes
  resources :projects, defaults: { format: :json, methods: %w(services domain url state state_ok problem_count account_number resources resources_unit icon cpu hdd ram status users details order_history) }, only: [:index, :show]
  resources :projects, defaults: { format: :json }, except: [:index, :show, :edit, :new] do
    member do
      get :staff, to: 'projects#staff', as: :staff_for
      match 'staff/:staff_id' => 'projects#add_staff', :via => :post, as: :add_staff_to
      match 'staff/:staff_id' => 'projects#remove_staff', :via => :delete, as: :remove_staff_from
      match 'approve' => 'projects#approve', :via => :put, as: :approve_project
      match 'reject' => 'projects#reject', :via => :put, as: :reject_project
    end
  end

  # ProjectQuestion Routes
  resources :project_questions, except: [:edit, :new], defaults: { format: :json }

  # Setting Routes
  resources :settings, defaults: { format: :json }, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  # Automate Routes
  get 'automate/catalog_item_initialization', to: 'automate#catalog_item_initialization'
  get 'automate/update_servicemix_and_chef', to: 'automate#update_servicemix_and_chef'

  root 'welcome#index'

  # # Dashboard Routes
  # resources :dashboard
  #
  # # Manage Routes
  # resources :manage
  #
  # # Marketplace Routes
  # resources :marketplace
  #
  # # Service Routes
  # resources :service

  # Mocks routes
  # TODO: Remove when implemented
  get 'applications/:id', to: 'mocks#application', defaults: { format: :json }
  get 'applications', to: 'mocks#applications', defaults: { format: :json }
  get 'bundles/:id', to: 'mocks#bundle', defaults: { format: :json }
  get 'bundles', to: 'mocks#bundles', defaults: { format: :json }
  get 'services/:id', to: 'mocks#service', defaults: { format: :json }
  get 'services', to: 'mocks#services', defaults: { format: :json }
  get 'solutions/:id', to: 'mocks#solution', defaults: { format: :json }
  get 'solutions', to: 'mocks#solutions', defaults: { format: :json }
  get 'alerts', to: 'mocks#alerts', defaults: { format: :json }
  get 'alertPopup', to: 'mocks#alert_popup', defaults: { format: :json }
  get 'header', to: 'mocks#header', defaults: { format: :json }
  get 'manage', to: 'mocks#manage', defaults: { format: :json }
  get 'marketplace', to: 'mocks#marketplace', defaults: { format: :json }
  get 'new-project', to: 'mocks#new_project', defaults: { format: :json }

end
