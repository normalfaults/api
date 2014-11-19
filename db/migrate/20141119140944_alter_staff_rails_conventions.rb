class AlterStaffRailsConventions < ActiveRecord::Migration
  def change
    add_column :staff, :deleted_at, :datetime

    add_index :staff, :deleted_at
  end
end
