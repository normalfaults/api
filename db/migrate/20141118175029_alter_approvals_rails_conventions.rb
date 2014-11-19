class AlterApprovalsRailsConventions < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        change_column :approvals, :approved, "boolean USING CAST(CASE approved WHEN 'Y' THEN 't' ELSE 'f' END AS boolean)"
      end
      dir.down do
        change_column :approvals, :approved, "varchar(1) USING CAST(CASE approved WHEN 't' THEN 'Y' ELSE 'N' END AS text)"
      end
    end

    add_index :approvals, :staff_id
    add_index :approvals, :project_id
  end
end
