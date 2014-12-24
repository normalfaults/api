class AddDefaultsAndTotalToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :total, :float, default: 0.0
    change_column :orders, :provision_status, :string, default: 'Pending'
  end
end
