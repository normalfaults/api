class DropProductCategories < ActiveRecord::Migration
  def change
    drop_table :product_categories
  end
end
