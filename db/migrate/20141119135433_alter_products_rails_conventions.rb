class AlterProductsRailsConventions < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        change_column :products, :active, "boolean USING CAST(CASE active WHEN 1 THEN 't' ELSE 'f' END AS boolean)"
      end
      dir.down do
        change_column :products, :active, "integer USING CAST(CASE active WHEN 't' THEN 1 ELSE 0 END AS integer)", limit: 1
      end
    end

    add_column :products, :deleted_at, :datetime

    add_index :products, :cloud_id
    add_index :products, :deleted_at
  end
end
