class CreateUserSettingOptions < ActiveRecord::Migration
  def change
    create_table :user_setting_options do |t|
      t.string :label, limit: 255, null: :no
      t.string :field_type, limit: 100, null: :no
      t.string :help_text, limit: 255
      t.text :options
      t.boolean :required, default: true
      t.timestamps
      t.datetime :deleted_at
      t.index :label, unique: true
      t.index :deleted_at
    end
  end
end
