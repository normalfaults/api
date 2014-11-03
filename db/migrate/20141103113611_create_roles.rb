class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name, limit: 255
      t.integer :access
      t.text :description
      t.timestamps
    end
  end
end
