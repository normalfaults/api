class AlterAlertsWithCorrections < ActiveRecord::Migration
  def change
    remove_column :alerts, :app_id
    add_column :alerts, :start_date, :datetime
    add_column :alerts, :end_date, :datetime
    add_index :alerts, :start_date
    add_index :alerts, :end_date
    add_index :alerts, :status
  end
end
