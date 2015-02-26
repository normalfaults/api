class AddPrivateIpToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :private_ip, :inet 
  end
end
