# == Schema Information
#
# Table name: orders
#
#  id              :integer          not null, primary key
#  staff_id        :integer          not null
#  engine_response :text
#  active          :boolean
#  created_at      :datetime
#  updated_at      :datetime
#  options         :json
#  deleted_at      :datetime
#  total           :float            default(0.0)
#
# Indexes
#
#  index_orders_on_deleted_at  (deleted_at)
#  index_orders_on_staff_id    (staff_id)
#

class Order < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :staff
  has_many :order_items

  store_accessor :options

  accepts_nested_attributes_for :order_items

  def item_count
    order_items.count
  end

  def item_count_for_project_id(pid)
    order_items.where(project_id: pid).count
  end
end
