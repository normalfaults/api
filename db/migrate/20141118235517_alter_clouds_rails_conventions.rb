class AlterCloudsRailsConventions < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        add_column :clouds, :extra, :text
        execute 'UPDATE clouds SET extra = data'
        remove_column :clouds, :data
      end

      dir.down do
        add_column :clouds, :data, :text
        execute 'UPDATE clouds SET "data" = extra'
        remove_column :clouds, :extra
      end
    end

    add_column :clouds, :deleted_at, :datetime

    add_index :clouds, :deleted_at
  end
end
