class AddRoleToStaff < ActiveRecord::Migration
  def change
    add_column :staff, :role, :integer, default: 0
  end
end
