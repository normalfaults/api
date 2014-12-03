class CreateProjectDetails < ActiveRecord::Migration
  def change
    create_table :project_details do |t|
      t.string :requestor_name
      t.date :requestor_date
      t.string :team_name
      t.integer :charge_number
      t.float :nte_budget
      t.string :project_owner
      t.string :sr_associate
      t.string :principal
      t.date :estimated_termination_date
      t.string :data_type
      t.string :others
      t.integer :project_id
      t.index :project_id
    end
  end
end
