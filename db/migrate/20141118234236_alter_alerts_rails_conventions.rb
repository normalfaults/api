class AlterAlertsRailsConventions < ActiveRecord::Migration
  def change
    add_index :alerts, :project_id
    add_index :alerts, :staff_id
  end
end
