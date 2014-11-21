class Chargeback < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :cloud
  belongs_to :product
end
