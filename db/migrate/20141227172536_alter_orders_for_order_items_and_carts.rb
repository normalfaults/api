class AlterOrdersForOrderItemsAndCarts < ActiveRecord::Migration
  def change
    remove_column :orders, :product_id
    remove_column :orders, :cloud_id
    remove_column :orders, :provision_status
  end
end
