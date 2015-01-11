class AlterOrderItemWHostAndPort < ActiveRecord::Migration
  def change
    add_column :order_items, :host, :string
    add_column :order_items, :port, :integer
  end
end
