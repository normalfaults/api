class CreateClouds < ActiveRecord::Migration
  def change
    create_table :clouds do |t|
      t.string :name, limit: 255
      t.text :description
      t.text :data
      t.timestamps
    end
  end
end
