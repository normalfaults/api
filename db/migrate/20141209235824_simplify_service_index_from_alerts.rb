class SimplifyServiceIndexFromAlerts < ActiveRecord::Migration
  def change
    remove_index :alerts, name: 'service_status_index'
    add_index(:alerts, [:project_id, :order_id, :status], name: 'service_status_index')
  end
end
