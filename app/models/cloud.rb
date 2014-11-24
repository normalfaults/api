class Cloud < ActiveRecord::Base
  acts_as_paranoid

  has_many :chargebacks
  has_many :orders
  has_many :products
end
