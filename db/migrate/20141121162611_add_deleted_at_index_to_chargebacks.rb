class AddDeletedAtIndexToChargebacks < ActiveRecord::Migration
  def change
    add_index :chargebacks, :deleted_at
  end
end
