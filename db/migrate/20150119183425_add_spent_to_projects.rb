class AddSpentToProjects < ActiveRecord::Migration
  def change
    # CHARGEBACK FOR THE PROJECT IS STORED IN THIS COLUMN
    add_column :projects, :spent, :decimal, precision: 12, scale: 2, default: 0.0
  end
end
