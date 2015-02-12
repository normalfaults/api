# == Schema Information
#
# Table name: project_details
#
#  id                         :integer          not null, primary key
#  requestor_name             :string(255)
#  requestor_date             :date
#  team_name                  :string(255)
#  charge_number              :integer
#  nte_budget                 :float
#  project_owner              :string(255)
#  sr_associate               :string(255)
#  principal                  :string(255)
#  estimated_termination_date :date
#  data_type                  :string(255)
#  others                     :string(255)
#  project_id                 :integer
#
# Indexes
#
#  index_project_details_on_project_id  (project_id)
#

class ProjectDetail < ActiveRecord::Base
  belongs_to :project
end
