class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :product_id
      t.integer :project_id
      t.integer :staff_id
      t.integer :cloud_id
      t.text :options
      t.text :engine_response
      t.string :provision_status, limit: 50
      t.integer :active, limit: 1
      t.timestamps
    end
  end
end
