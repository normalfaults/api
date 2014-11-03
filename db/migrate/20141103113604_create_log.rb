class CreateLog < ActiveRecord::Migration
  def change
    create_table :log do |t|
      t.integer :staff_id
      t.integer :level
      t.text :message
      t.timestamps
    end
  end
end
