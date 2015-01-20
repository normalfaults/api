class ChangeProvisionStatusToInteger < ActiveRecord::Migration
  def change
    change_column :order_items, :provision_status, 'integer USING CAST(provision_status AS integer)'
  end
end
