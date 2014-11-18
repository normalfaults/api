class Project < ActiveRecord::Base
  has_many :staff_projects
  has_many :staff, through: :staff_projects
end
