class ChangeTypeOfOptionsFromProducts < ActiveRecord::Migration
  def change
    remove_column :products, :options
    add_column :products, :options, :json
  end
end
