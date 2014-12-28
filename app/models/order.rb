class Order < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :project
  belongs_to :cloud
  belongs_to :staff
  has_many :order_items

  store_accessor :options

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
      order_items.destroy_all
      insert_items!(items)
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
