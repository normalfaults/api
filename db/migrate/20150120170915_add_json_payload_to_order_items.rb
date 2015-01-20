class AddJsonPayloadToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :payload_to_miq, :json
    add_column :order_items, :payload_from_miq, :json
  end
end