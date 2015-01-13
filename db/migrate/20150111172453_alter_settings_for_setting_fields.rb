class AlterSettingsForSettingFields < ActiveRecord::Migration
  def change
    remove_column :setting_fields, :admin_setting_id
    add_column :setting_fields, :setting_id, :integer
    add_index :setting_fields, :setting_id
  end
end
