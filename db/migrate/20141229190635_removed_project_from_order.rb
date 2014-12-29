class RemovedProjectFromOrder < ActiveRecord::Migration
  class RemoveHostAndPortFromAlerts < ActiveRecord::Migration
    def change
      remove_column :orders, :project_id
    end
  end
end
