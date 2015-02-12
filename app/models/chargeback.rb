# == Schema Information
#
# Table name: chargebacks
#
#  id           :integer          not null, primary key
#  product_id   :integer
#  cloud_id     :integer
#  hourly_price :decimal(8, 2)
#  created_at   :datetime
#  updated_at   :datetime
#  deleted_at   :datetime
#
# Indexes
#
#  index_chargebacks_on_cloud_id    (cloud_id)
#  index_chargebacks_on_deleted_at  (deleted_at)
#  index_chargebacks_on_product_id  (product_id)
#

class Chargeback < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :cloud
  belongs_to :product
end
