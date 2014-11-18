class ChangeTypeOfOptionsFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :options
    add_column :orders, :options, :json
  end
end
