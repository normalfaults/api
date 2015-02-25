class FixOrderItemsColumnName < ActiveRecord::Migration
  def change
    rename_column :order_items, :ip_address, :public_ip
  end
end
