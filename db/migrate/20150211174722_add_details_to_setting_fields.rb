class AddDetailsToSettingFields < ActiveRecord::Migration
  def change
    add_column :setting_fields, :env_var_name, :string
    add_column :setting_fields, :disabled, :boolean, default: false
  end
end
