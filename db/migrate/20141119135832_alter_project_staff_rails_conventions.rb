class AlterProjectStaffRailsConventions < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        drop_table :project_staff
      end
      dir.down do
        create_table :project_staff do |t|
          t.integer :project_id
          t.integer :staff_id
          t.integer :role_id
          t.timestamps
        end
      end
    end
  end
end
