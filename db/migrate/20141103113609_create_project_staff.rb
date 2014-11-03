class CreateProjectStaff < ActiveRecord::Migration
  def change
    create_table :project_staff do |t|
      t.integer :project_id
      t.integer :staff_id
      t.integer :role_id
      t.timestamps
    end
  end
end
