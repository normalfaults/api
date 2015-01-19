class ProductAnswer < ActiveRecord::Base
  belongs_to :product
  belongs_to :question, class_name: 'ProductTypeQuestion'
end
