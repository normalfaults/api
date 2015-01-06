class Order < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :staff
  has_many :order_items

  store_accessor :options

  def item_count_for_project_id(pid)
    order_items.where(project_id: pid).count
  end

  def self.create_with_items(attributes)
    items = items_from_attrs! attributes
    order = nil

    transaction do
      order = create!(attributes)
      order.insert_items!(items)
    end

    order
  end

  def update_with_items!(attributes)
    items = self.class.items_from_attrs! attributes

    self.class.transaction do
      update_attributes(attributes)

      update_items!(items)
    end
  end

  def update_items!(items)
    items ||= []
    items.each do |item|
      updated_item = order_items.find_or_initialize_by(id: item[:id])
      item.delete(:id)
      updated_item.update(item)
    end
  end

  def insert_items!(items)
    items ||= []
    items.each do |item|
      order_items.create!(item)
    end
  end

  def self.items_from_attrs!(attributes)
    items = attributes[:order_items]
    attributes.delete :order_items
    items
  end
end
