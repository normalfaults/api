class AddReasonToApprovals < ActiveRecord::Migration
  def change
    add_column :approvals, :reason, :text
  end
end
