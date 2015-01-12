class AddIndexOnOrderItemPortAndHost < ActiveRecord::Migration
  def change
    add_index :order_items, [:port, :host]
  end
end
