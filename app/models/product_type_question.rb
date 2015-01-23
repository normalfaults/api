class ProductTypeQuestion < ActiveRecord::Base
  belongs_to :product_type
  has_many :product_answers
end
