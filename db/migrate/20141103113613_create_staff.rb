class CreateStaff < ActiveRecord::Migration
  def change
    create_table :staff do |t|
      t.string :first_name, limit: 255
      t.string :last_name, limit: 255
      t.string :email, limit: 255
      t.string :phone, limit: 30
      t.text :password
      t.timestamps
    end
  end
end
