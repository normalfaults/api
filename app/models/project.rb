class Project < ActiveRecord::Base
  acts_as_paranoid

  has_many :staff_projects
  has_many :staff, through: :staff_projects
end
