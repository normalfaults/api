require 'rails_helper'

RSpec.describe 'Order Items API' do
  let(:default_params) { { format: :json } }
  let(:project) { create :project }
  let(:product) { create :product }

  before(:each) do
    @order = Order.create_with_items(staff_id: 1, order_items: [{ product_id: product.id, project_id: project.id }, { product_id: product.id, project_id: project.id }])
    sign_in_as create :staff, :admin
    @order_item = @order.order_items.first
  end

  describe 'GET show' do
    it 'returns an order item', :show_in_doc do
      get "/orders/#{@order.id}/items/#{@order_item.id}"
      expect(response.body).to eq(@order_item.to_json)
    end

    it 'returns an error when the order item does not exist' do
      get "/orders/#{@order.id}/items/#{@order_item.id + 999}"
      expect(response.status).to eq(404)
      expect(json).to eq('error' => 'Not found.')
    end

    it 'returns an error when the order does not exist' do
      get "/orders/#{@order.id + 999}/items/#{@order_item.id}"
      expect(response.status).to eq(404)
      expect(json).to eq('error' => 'Not found.')
    end
  end

  describe 'PUT update' do
    it 'update an order item', :show_in_doc do
      put "/orders/#{@order.id}/items/#{@order_item.id}", port: 123, host: 'www.example.com'

      @order_item.provision_status
      expect(response.body).to eq(OrderItem.all.first.to_json(methods: [:provision_status]))
    end

    it 'returns an error when the order item does not exist' do
      get "/orders/#{@order.id}/items/#{@order_item.id + 999}"
      expect(response.status).to eq(404)
      expect(json).to eq('error' => 'Not found.')
    end

    it 'returns an error when the order does not exist' do
      get "/orders/#{@order.id + 999}/items/#{@order_item.id}"
      expect(response.status).to eq(404)
      expect(json).to eq('error' => 'Not found.')
    end
  end

  describe 'DELETE destroy' do
    before :each do
      @order = Order.create_with_items(staff_id: 1, order_items: [{ product_id: product.id, project_id: project.id }])
      @order_item = @order.order_items.first
    end

    it 'removes the order item', :show_in_doc do
      delete "/orders/#{@order.id}/items/#{@order_item.id}"
      expect(response.status).to eq(200)
    end

    it 'returns an error when the order item does not exist' do
      delete "/orders/#{@order.id}/items/#{@order_item.id + 999}"
      expect(response.status).to eq(404)
      expect(json).to eq('error' => 'Not found.')
    end
  end

  describe 'Item service start / stop' do
    it 'can be started', :show_in_doc do
      put "/orders/#{@order.id}/items/#{@order_item.id}/start_service"
      expect(response.status).to eq(200)
    end

    it 'can be stopped', :show_in_doc do
      put "/orders/#{@order.id}/items/#{@order_item.id}/stop_service"
      expect(response.status).to eq(200)
    end
  end
end
