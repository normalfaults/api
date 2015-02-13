# == Schema Information
#
# Table name: carts
#
#  id         :integer          not null, primary key
#  count      :integer
#  staff_id   :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_carts_on_staff_id  (staff_id)
#

class Cart < ActiveRecord::Base
  has_many :orders
end
