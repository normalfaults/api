class RemoveHostAndPortFromAlerts < ActiveRecord::Migration
  def change
    remove_index :alerts, :host
    remove_index :alerts, :port
    remove_index :alerts, name: 'service_status_index'
    remove_index :alerts, name: 'service_index'
    remove_index :alerts, :project_id
    remove_index :alerts, :staff_id
    remove_index :alerts, :order_id
    remove_index :alerts, :status
    remove_column :alerts, :host
    remove_column :alerts, :port
    add_index(:alerts, [:project_id, :staff_id, :order_id, :status], name: 'service_status_index')
  end
end
