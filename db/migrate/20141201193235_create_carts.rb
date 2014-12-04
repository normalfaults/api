class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.integer :count
      t.integer :staff_id
      t.index :staff_id
      t.timestamps
    end
  end
end
