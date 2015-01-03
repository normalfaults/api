class AddProjectToOrderItem < ActiveRecord::Migration
  def change
    add_column :order_items, :project_id, :integer
  end
end
