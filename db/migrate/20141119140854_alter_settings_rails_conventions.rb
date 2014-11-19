class AlterSettingsRailsConventions < ActiveRecord::Migration
  def change
    add_index :settings, :name
  end
end
