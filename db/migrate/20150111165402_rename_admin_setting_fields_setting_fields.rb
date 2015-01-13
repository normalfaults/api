class RenameAdminSettingFieldsSettingFields < ActiveRecord::Migration
  def change
    rename_table :admin_setting_fields, :setting_fields
  end
end
