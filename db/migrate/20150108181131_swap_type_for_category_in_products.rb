class SwapTypeForCategoryInProducts < ActiveRecord::Migration
  def change
    remove_column :products, :product_category_id
    add_column :products, :product_type_id, :integer

    add_index :products, :product_type_id
  end
end
