class AlterLogsRailsConventions < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        create_table :logs do |t|
          t.integer :staff_id, null: false
          t.integer :level
          t.text :message
          t.timestamps

          t.index :staff_id
        end

        drop_table :log
      end
      dir.down do
        create_table :log do |t|
          t.integer :staff_id
          t.integer :level
          t.text :message
          t.timestamps
        end

        drop_table :logs
      end
    end
  end
end
