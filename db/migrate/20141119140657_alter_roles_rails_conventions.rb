class AlterRolesRailsConventions < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up { drop_table :roles }
      dir.down do
        create_table :roles do |t|
          t.string :name, limit: 255
          t.integer :access
          t.text :description
          t.timestamps
        end
      end
    end
  end
end
