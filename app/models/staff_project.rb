# == Schema Information
#
# Table name: staff_projects
#
#  id         :integer          not null, primary key
#  staff_id   :integer
#  project_id :integer
#
# Indexes
#
#  index_staff_projects_on_project_id               (project_id)
#  index_staff_projects_on_staff_id_and_project_id  (staff_id,project_id) UNIQUE
#

class StaffProject < ActiveRecord::Base
  belongs_to :staff
  belongs_to :project
end
