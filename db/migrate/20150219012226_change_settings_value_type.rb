class ChangeSettingsValueType < ActiveRecord::Migration
  def up
    change_column :setting_fields, :value, :text
  end

  def down
    change_column :settings_fields, :value, :string
  end
end
