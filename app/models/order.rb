class Order < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :staff
  belongs_to :product
  belongs_to :project
  belongs_to :cloud

  has_many :chargebacks

  store_accessor :options
end
