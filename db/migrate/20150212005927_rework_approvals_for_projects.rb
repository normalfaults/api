class ReworkApprovalsForProjects < ActiveRecord::Migration
  def up
    add_column :projects, :approval, :integer, default: 0
    Project.update_all("approval = CASE approved WHEN 't' THEN 1 ELSE 0 END")
    remove_column :projects, :approved
  end

  def down
    add_column :projects, :approved, :boolean, default: false
    Project.update_all("approved = CASE approval WHEN 1 THEN 't' ELSE 'f' END")
    remove_column :projects, :approval
  end
end
