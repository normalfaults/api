class CreateChargebacks < ActiveRecord::Migration
  def change
    create_table :chargebacks do |t|
      t.integer :product_id
      t.integer :cloud_id
      t.float :hourly_price
      t.timestamps
    end
  end
end
