class ChangeProvisionStatusToInteger < ActiveRecord::Migration
  def change
    change_column :order_items, :provision_status, "integer USING CAST(CASE provision_status WHEN '0' THEN 4 ELSE 3 END AS integer)"
  end
end
