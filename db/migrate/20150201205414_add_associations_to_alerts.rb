class AddAssociationsToAlerts < ActiveRecord::Migration
  def change
    remove_column :alerts, :order_id
    add_column :alerts, :order_item_id, :integer
    add_index :alerts, [:order_item_id], name: 'index_order_item_id'
  end
end
