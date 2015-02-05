class AddLatestAlertToOrderItem < ActiveRecord::Migration
  def change
    add_column :order_items, :latest_alert_id, :integer
  end
end
