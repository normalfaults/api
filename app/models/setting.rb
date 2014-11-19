class Setting < ActiveRecord::Base
  validates :name, uniqueness: TRUE
end
