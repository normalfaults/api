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

describe Order do
  context 'persistence' do
    let(:options) { [{ dialog_name: 'name' }, { dialog_name: 'name2' }] }
    let(:staff) { create :staff }
    let(:product) { create :product }
    let(:project) { create :project }
    let(:order_item_model) { { product_id: product.id, project_id: project.id } }

    it 'creates items w/ a product' do
      items = [order_item_model]
      order = Order.create(order_items_attributes: items, staff_id: staff.id)
      expect(order.order_items.count).to eq(1)
    end

    it 'creates an order with items' do
      order = Order.create(order_items_attributes: [order_item_model], staff_id: staff.id)
      expect(order.order_items.count).to eq(1)
    end

    it 'updates an order with items' do
      order = Order.create(order_items_attributes: [order_item_model], staff_id: staff.id)
      items = [{ id: order.order_items.first.id, port: 1234 }]

      order.update!(order_items_attributes: items)

      expect(order.order_items.count).to eq(1)
    end

    it 'can store unstructured options' do
      create :order, options: options
      order = Order.first

      expect(order.options[0][:dialog_name]).to eq(options[0]['dialog_name'])
      expect(order.options[1][:dialog_name]).to eq(options[1]['dialog_name'])
    end
  end
end
