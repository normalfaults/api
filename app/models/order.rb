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
