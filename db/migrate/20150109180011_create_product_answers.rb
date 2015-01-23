class CreateProductAnswers < ActiveRecord::Migration
  def change
    create_table :product_answers do |t|
      t.integer :product_id, null: false
      t.integer :product_type_question_id, null: false
      t.text :answer

      t.timestamps

      t.index :product_id
      t.index :product_type_question_id
    end
  end
end
