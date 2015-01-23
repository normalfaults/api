class AddPayloadResponseFromMiqToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :payload_response_from_miq, :json
  end
end
