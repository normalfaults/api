class AddChargebackAttributes < ActiveRecord::Migration
  def change
    # APPLIED ONLY ONCE PER SERVICE INSTANCE AFTER ITS CREATION
    add_column :products, :setup_price, :decimal, precision: 10, scale: 4, default: 0.0
    add_column :order_items, :setup_price, :decimal, precision: 10, scale: 4, default: 0.0
    # APPLIED ONCE FOR EVERY HOUR SINCE SERVICE INSTANCE WAS CREATED
    add_column :products, :hourly_price, :decimal, precision: 10, scale: 4, default: 0.0
    add_column :order_items, :hourly_price, :decimal, precision: 10, scale: 4, default: 0.0
    # APPLIED ONCE FOR EVERY MONTH SINCE SERVICE INSTANCE WAS CREATED
    add_column :products, :monthly_price, :decimal, precision: 10, scale: 4, default: 0.0
    add_column :order_items, :monthly_price, :decimal, precision: 10, scale: 4, default: 0.0
  end
end
