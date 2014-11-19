class AlterOrdersRailsConventions < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        change_column_null :orders, :product_id, false
        change_column_null :orders, :project_id, false
        change_column_null :orders, :staff_id, false
        change_column_null :orders, :cloud_id, false
        change_column :orders, :active, "boolean USING CAST(CASE active WHEN 1 THEN 't' ELSE 'f' END AS boolean)"
      end
      dir.down do
        change_column_null :orders, :product_id, true
        change_column_null :orders, :project_id, true
        change_column_null :orders, :staff_id, true
        change_column_null :orders, :cloud_id, true
        change_column :orders, :active, "integer USING CAST(CASE active WHEN 't' THEN 1 ELSE 0 END AS integer)", limit: 1
      end
    end

    add_column :orders, :deleted_at, :datetime

    add_index :orders, :product_id
    add_index :orders, :project_id
    add_index :orders, :staff_id
    add_index :orders, :cloud_id
    add_index :orders, :deleted_at
  end
end
