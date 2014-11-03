class CreateApprovals < ActiveRecord::Migration
  def change
    create_table :approvals do |t|
      t.integer :staff_id
      t.integer :project_id
      t.string :approved, limit: 1
      t.timestamps
    end
  end
end
