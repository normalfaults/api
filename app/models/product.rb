class Product < ActiveRecord::Base
  acts_as_paranoid

  store_accessor :options

  has_many :chargebacks
  belongs_to :cloud
  belongs_to :product_type
  has_many :answers, class_name: 'ProductAnswer'

  accepts_nested_attributes_for :answers
end
