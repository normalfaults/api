class Approval < ActiveRecord::Base
  belongs_to :staff
  belongs_to :project
end
