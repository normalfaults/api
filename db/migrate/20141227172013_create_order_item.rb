class CreateOrderItem < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.integer :order_id
      t.integer :cloud_id
      t.integer :product_id
      t.integer :service_id
      t.string :provision_status
      t.timestamps
      t.datetime :deleted_at
      t.index :product_id
      t.index :cloud_id
      t.index :service_id
      t.index :order_id
      t.index :deleted_at
    end
  end
end
