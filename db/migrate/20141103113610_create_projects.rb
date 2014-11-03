class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name, limit: 255
      t.text :description
      t.string :cc, limit: 10
      t.float :budget
      t.string :staff_id, limit: 255
      t.date :start_date
      t.date :end_date
      t.string :approved, limit: 1
      t.string :img, limit: 255
      t.timestamps
    end
  end
end
