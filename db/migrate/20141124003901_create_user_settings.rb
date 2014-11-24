class CreateUserSettings < ActiveRecord::Migration
  def change
    create_table :user_settings do |t|
      t.belongs_to :staff
      t.string :name, limit: 255
      t.text :value
      t.timestamps
      t.datetime :deleted_at
      t.index [:staff_id, :name], unique: true
      t.index :deleted_at
    end
  end
end
