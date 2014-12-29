describe Order do
  context 'persistence' do
    let(:options) { [{ dialog_name: 'name' }, { dialog_name: 'name2' }] }
    let(:staff) { create :staff }
    let(:product) { create :product }
    let(:project) { create :project }
    let(:order_item_model) { { product_id: product.id, project_id: project.id } }

    it 'creates items w/ a product' do
      items = [order_item_model]
      order = Order.create_with_items(order_items: items, staff_id: staff.id)
      expect(order.order_items.count).to eq(1)
    end

    it 'raises an exception when items are missing a product' do
      items = [{ product_id: nil }]
      expect { Order.create_with_items(order_items: items, staff_id: staff.id) }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'updates an order with items' do
      items = [order_item_model, order_item_model]
      order = create :order
      order.update_with_items!(order_items: items)

      expect(order.order_items.count).to eq(2)
    end

    it 'can store unstructured options' do
      create :order, options: options
      order = Order.first

      expect(order.options[0][:dialog_name]).to eq(options[0]['dialog_name'])
      expect(order.options[1][:dialog_name]).to eq(options[1]['dialog_name'])
    end
  end
end
