class RenameAdminSettingsSettings < ActiveRecord::Migration
  def change
    rename_table :admin_settings, :settings
  end
end
