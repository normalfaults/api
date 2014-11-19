class AlterNameIndexOnSettings < ActiveRecord::Migration
  def change
    remove_index :settings, :name
    add_index :settings, :name, unique: true
  end
end
