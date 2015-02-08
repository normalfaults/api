Rails.application.routes.draw do
  # Docs
  apipie

  # Auth
  devise_for :staff, controllers: { sessions: 'sessions' }

  # Alerts Routes
  resources :alerts, defaults: { format: :json } do
    collection do
      post :sensu
    end
  end

  # User Setting Options Routes
  resources :user_setting_options, defaults: { format: :json }

  # Approvals
  resources :staff, defaults: { format: :json, methods: %w(gravatar) }, only: [:index]
  resources :staff, defaults: { format: :json }, only: [:show, :create, :update, :destroy] do
    # Staff Orders
    resources :orders, controller: 'staff_orders', defaults: { format: :json, includes: %w(order_items) }, only: [:show, :index]

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

  # Provision Request Response
  resources :order_items, defaults: { format: :json }, only: [:update] do
    member do
      put :provision_update
    end
  end

  # Orders
  resources :orders, except: [:edit, :new], defaults: { format: :json, includes: %w(order_items) } do
    # Order Items
    resources :items, controller: 'order_items', except: [:index, :edit, :new, :create], defaults: { format: :json, includes: [] } do
      member do
        put :start_service
        put :stop_service
      end
    end
  end

  # Products
  resources :products, except: [:edit, :new], defaults: { format: :json } do
    member do
      get :answers
    end
  end

  # ProductTypes
  resources :product_types, except: [:edit, :new], defaults: { format: :json } do
    member do
      get :questions
    end
  end

  # Chargebacks
  resources :chargebacks, except: [:edit, :new], defaults: { format: :json }

  # Clouds
  resources :clouds, except: [:edit, :new], defaults: { format: :json }

  # Project Routes
  resources :projects, defaults: { format: :json, includes: %w(project_answers services), methods: %w(domain url state state_ok problem_count account_number resources resources_unit icon cpu hdd ram status monthly_spend users order_history) }, only: [:show]
  resources :projects, defaults: { format: :json, methods: %w(domain url state state_ok problem_count account_number resources resources_unit icon cpu hdd ram status monthly_spend) }, only: [:index]
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

  # Admin Settings
  resources :settings, defaults: { format: :json, includes: %w(setting_fields)  }, only: [:index, :update, :show, :edit, :new, :destroy]
  resources :settings, defaults: { format: :json, includes: %w(setting_fields)  }, only: [:show], param: :name

  # Automate Routes
  resources :automate, only: [] do
    collection do
      get :catalog_item_initialization
      get :update_servicemix_and_chef
      get :provision_rds

      get :create_ec2
      get :create_rds
      get :create_s3
      get :create_ses
      get :create_vmware_vm

      get :retire_ec2
      get :retire_rds
      get :retire_s3
      get :retire_ses
      get :retire_vmware_vm
    end
  end

  root 'welcome#index'
end
