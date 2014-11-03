class CreateInitialSchemas < ActiveRecord::Migration
    def change

      create_table :organizations do |t|
        t.string :name, limit: 255
        t.text :description
        t.string :img, limit: 255 # size MUST be 200x200 pixels
        t.timestamps
      end

      create_table :projects do |t|
        t.string :name, limit: 255
        t.text :description
        t.string :cc, limit: 10 # This is what was formerly known as the "app_code", it is now the cost center, or the "cc" tag in MIQ
        t.float :budget # assumes USD
        t.string :staff_id, limit: 255
        t.date :start_date
        t.date :end_date
        t.string :approved, limit: 1 # Y = approved, N = Not approved.
        t.string :img, limit: 255 # size MUST be 200x200 pixels
        t.timestamps
      end

      create_table :products do |t|
        t.string :name, limit: 255
        t.text :description
        t.integer :service_type_id # corresponds to service type in MIQ
        t.integer :service_catalog_id # corresponds to catalog id in MIQ
        t.integer :cloud_id
        t.string :chef_role, limit: 100
        t.text :options # 'options' is a reserved word, rename; Please see Catalog Options JSON Definitions in Confluence
        t.integer :active, limit: 1
        t.string :img, limit: 255 # size MUST be 200x200 pixels
        t.timestamps
      end

      create_table :orders do |t|
        t.integer :product_id
        t.integer :project_id
        t.integer :staff_id
        t.integer :cloud_id
        t.text :options # 'options' is a reserved word, rename; Please see Catalog Options JSON Definitions in Confluence
        t.text :engine_response #'return' is a reserved word
        t.string :provision_status, limit: 50 # Please see Messaging Status Code Definitions in Confluence
        t.integer :active, limit: 1
        t.timestamps
      end

      create_table :chargebacks do |t|
        t.integer :product_id
        t.integer :cloud_id
        t.float :hourly_price
        t.timestamps
      end

      create_table :clouds do |t|
        t.string :name, limit: 255
        t.text :description
        t.text :data
        t.timestamps
      end

      create_table :staff do |t|
        t.string :first_name, limit: 255
        t.string :last_name, limit: 255
        t.string :email, limit: 255
        t.string :phone, limit: 30
        t.text :password
        t.timestamps
      end

      create_table :project_staff do |t|
        t.integer :project_id
        t.integer :staff_id
        t.integer :role_id
        t.timestamps
      end

      create_table :roles do |t|
        t.string :name, limit: 255
        t.integer :access
        t.text :description
        t.timestamps
      end

      create_table :alerts do |t|
        t.integer :project_id # 0 if does not apply to a specific person
        t.integer :app_id # 0 if does not apply to a specific app
        t.integer :staff_id # 0 for all people
        t.string :status, limit: 20 # Please see Messaging Status Code Definitions in Confluence
        t.string :message, limit: 255
        t.timestamps
      end

      create_table :log do |t|
        t.integer :staff_id # 0 for general alert
        t.integer :level
        t.text :message
        t.timestamps
      end

      create_table :approvals do |t|
        t.integer :staff_id
        t.integer :project_id
        t.string :approved, limit: 1 # Y = approved, N = Not approved.
        t.timestamps
      end

      create_table :project_questions do |t|
        t.string :question, limit: 255
        t.string :field_type, limit: 100
        t.string :help_text, limit: 255
        t.text :options
        t.string :required, limit: 1 # Y = required, N = Not required.
        t.timestamps
      end

      create_table :settings do |t|
        t.string :name, limit: 255
        t.text :value
        t.timestamps
      end

    end
end
