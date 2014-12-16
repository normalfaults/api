class AddCompositeKeyToAlerts < ActiveRecord::Migration
  def change
    add_index(:alerts, [:status, :message, :project_id, :staff_id], unique: true, name: 'tuple_index')
  end
end
