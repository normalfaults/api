class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name, limit: 255
      t.text :description
      t.integer :service_type_id
      t.integer :service_catalog_id
      t.integer :cloud_id
      t.string :chef_role, limit: 100
      t.text :options
      t.integer :active, limit: 1
      t.string :img, limit: 255
      t.timestamps
    end
  end
end
