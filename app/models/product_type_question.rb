# == Schema Information
#
# Table name: product_type_questions
#
#  id              :integer          not null, primary key
#  product_type_id :integer          not null
#  label           :text
#  field_type      :string(255)
#  placeholder     :string(255)
#  help            :text
#  options         :json
#  default         :text
#  required        :boolean          default(FALSE)
#  load_order      :integer
#  manageiq_key    :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#
# Indexes
#
#  question_order_idx  (product_type_id,load_order)
#

class ProductTypeQuestion < ActiveRecord::Base
  belongs_to :product_type
  has_many :product_answers
end
