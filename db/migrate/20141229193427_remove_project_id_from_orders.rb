class RemoveProjectIdFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :project_id
  end
end
