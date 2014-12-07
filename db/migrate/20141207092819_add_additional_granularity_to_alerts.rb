class AddAdditionalGranularityToAlerts < ActiveRecord::Migration
  def change
    remove_index :alerts, name: 'tuple_index'

    remove_column :alerts, :project_id
    remove_column :alerts, :staff_id
    remove_column :alerts, :status
    remove_column :alerts, :message
    remove_column :alerts, :start_date
    remove_column :alerts, :end_date
    remove_timestamps :alerts

    add_column :alerts, :project_id, :integer
    add_column :alerts, :staff_id, :integer
    add_column :alerts, :order_id, :integer
    add_column :alerts, :host, :string
    add_column :alerts, :port, :integer
    add_column :alerts, :status, :string, limit: 20
    add_column :alerts, :message, :text
    add_column :alerts, :start_date, :datetime
    add_column :alerts, :end_date, :datetime
    add_timestamps :alerts

    add_index :alerts, :project_id
    add_index :alerts, :staff_id
    add_index :alerts, :order_id
    add_index :alerts, :host
    add_index :alerts, :port
    add_index :alerts, :status
    add_index :alerts, :start_date
    add_index :alerts, :end_date
    add_index(:alerts, [:project_id, :staff_id, :order_id, :host, :port], name: 'service_index')
    add_index(:alerts, [:project_id, :staff_id, :order_id, :host, :port, :status], name: 'service_status_index')
  end
end
