class AddDeletedAtToChargebacks < ActiveRecord::Migration
  def change
    add_column :chargebacks, :deleted_at, :datetime
  end
end
