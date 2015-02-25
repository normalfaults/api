class AddColumnsToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :url, :string
    add_column :order_items, :instance_name, :string
    add_column :order_items, :instance_id, :string
    add_column :order_items, :username, :string
    add_column :order_items, :password, :string
    add_column :order_items, :status_msg, :string
  end
end
