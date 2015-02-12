# == Schema Information
#
# Table name: product_types
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class ProductType < ActiveRecord::Base
  has_many :products
  has_many :questions, -> { order 'load_order ASC' }, class_name: 'ProductTypeQuestion'
end
