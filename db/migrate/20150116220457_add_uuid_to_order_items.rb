class AddUuidToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :uuid, :uuid, default: 'uuid_generate_v4()'
  end
end
