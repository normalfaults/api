class ChangeProvisionStatusToInteger < ActiveRecord::Migration
  def change
    change_column :order_items, :provision_status, "integer USING CAST(CASE provision_status WHEN '0' THEN 0 WHEN '1' THEN 1 WHEN '2' THEN 2 WHEN '3' THEN 3 WHEN '4' THEN 4 ELSE 3 END AS integer)"
  end
end
