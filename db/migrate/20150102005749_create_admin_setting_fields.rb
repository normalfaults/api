class CreateAdminSettingFields < ActiveRecord::Migration
  def change
    create_table :admin_setting_fields do |t|
      t.string :label, limit: 255
      t.integer :field_type, default: 0
      t.string :help_text, limit: 255
      t.json :options
      t.string :value
      t.string :required, limit: 1
      t.integer :load_order
      t.integer :admin_setting_id
      t.index :admin_setting_id
      t.timestamps
    end
  end
end
