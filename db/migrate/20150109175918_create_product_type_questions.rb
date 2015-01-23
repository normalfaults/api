class CreateProductTypeQuestions < ActiveRecord::Migration
  def change
    create_table :product_type_questions do |t|
      t.integer :product_type_id, null: false
      t.text :label
      t.string :field_type
      t.string :placeholder
      t.text :help
      t.column :options, :json
      t.text :default
      t.boolean :required, default: false
      t.integer :load_order
      t.string :manageiq_key

      t.timestamps

      # Index name length is too long for most DBs so we name it explicitly
      t.index [:product_type_id, :load_order], name: 'question_order_idx'
    end
  end
end
