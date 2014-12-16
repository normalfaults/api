class AddHostAndPortToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :host, :string
    add_column :orders, :port, :integer
  end
end
