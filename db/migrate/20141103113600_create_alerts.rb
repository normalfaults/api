class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.integer :project_id
      t.integer :app_id
      t.integer :staff_id
      t.string :status, limit: 20
      t.string :message, limit: 255
      t.timestamps
    end
  end
end
