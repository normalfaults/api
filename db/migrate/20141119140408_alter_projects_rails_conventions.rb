class AlterProjectsRailsConventions < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        change_column :projects, :approved, "boolean USING CAST(CASE approved WHEN 'Y' THEN 't' ELSE 'f' END AS boolean)"
      end
      dir.down do
        change_column :projects, :approved, "varchar(1) USING CAST(CASE approved WHEN 't' THEN 'Y' ELSE 'N' END AS text)"
      end
    end

    add_column :projects, :deleted_at, :datetime

    add_index :projects, :deleted_at
  end
end
