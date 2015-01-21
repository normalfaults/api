class ProductType < ActiveRecord::Base
  has_many :products
  has_many :questions, -> { order 'load_order ASC' }, class_name: 'ProductTypeQuestion'
end
