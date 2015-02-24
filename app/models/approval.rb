# == Schema Information
#
# Table name: approvals
#
#  id         :integer          not null, primary key
#  staff_id   :integer
#  project_id :integer
#  approved   :boolean
#  created_at :datetime
#  updated_at :datetime
#  reason     :text
#
# Indexes
#
#  index_approvals_on_project_id  (project_id)
#  index_approvals_on_staff_id    (staff_id)
#

class Approval < ActiveRecord::Base
  belongs_to :staff
  belongs_to :project

  def approve!
    self.class.transaction do
      self.approved = true
      save!
      project.approval = :approved
      project.save!
    end
  end

  def reject!(reason)
    self.class.transaction do
      self.approved = false
      self.reason = reason
      save!
      project.approval = :rejected
      project.save!
    end
  end
end
