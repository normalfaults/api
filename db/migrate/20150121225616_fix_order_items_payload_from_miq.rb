class FixOrderItemsPayloadFromMiq < ActiveRecord::Migration
  def change
    rename_column :order_items, :payload_from_miq, :payload_reply_from_miq
  end
end
