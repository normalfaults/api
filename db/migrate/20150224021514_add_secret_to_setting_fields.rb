class AddSecretToSettingFields < ActiveRecord::Migration
  def change
    add_column :setting_fields, :secret, :boolean, default: false, null: false
  end
end
