class AlterOrderRemoveHostAndPort < ActiveRecord::Migration
  def change
    remove_column :orders, :host
    remove_column :orders, :port
  end
end
