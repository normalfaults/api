class AddMiqIdIpAddressHostnameToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :miq_id, :integer
    add_index :order_items, :miq_id
    add_column :order_items, :ip_address, :inet
    add_column :order_items, :hostname, :string
    add_index :order_items, :hostname
  end
end
