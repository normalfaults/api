class AlterChargebacksRailsConventions < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up { change_column :chargebacks, :hourly_price, :decimal, precision: 8, scale: 2 }
      dir.down { change_column :chargebacks, :hourly_price, :float }
    end

    add_index :chargebacks, :cloud_id
    add_index :chargebacks, :product_id
  end
end
