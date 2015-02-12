# == Schema Information
#
# Table name: product_answers
#
#  id                       :integer          not null, primary key
#  product_id               :integer          not null
#  product_type_question_id :integer          not null
#  answer                   :text
#  created_at               :datetime
#  updated_at               :datetime
#
# Indexes
#
#  index_product_answers_on_product_id                (product_id)
#  index_product_answers_on_product_type_question_id  (product_type_question_id)
#

class ProductAnswer < ActiveRecord::Base
  belongs_to :product
  belongs_to :question, class_name: 'ProductTypeQuestion'
end
