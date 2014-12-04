class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.text :text
      t.text :ago
      t.integer :staff_id
      t.index :staff_id
      t.timestamps
    end
  end
end
