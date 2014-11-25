class ProjectQuestion < ActiveRecord::Base
  acts_as_paranoid

  has_many :project_answers
end
