class CreateJoinStaffProjects < ActiveRecord::Migration
  def change
    create_table :staff_projects do |t|
      t.integer :staff_id
      t.integer :project_id

      t.index [:staff_id, :project_id], unique: true
      t.index :project_id
    end
  end
end
