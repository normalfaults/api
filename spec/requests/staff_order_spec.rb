require 'rails_helper'

RSpec.describe 'Staff Orders API' do
  let(:default_params) { { format: :json } }
  let(:project) { create :project }
  let(:product) { create :product }

  describe 'GET show' do
    before(:each) do
      sign_in_as create :staff, :admin
      @order = Order.create(staff_id: Staff.all.first.id, order_items_attributes: [{ product_id: product.id, project_id: project.id }, { product_id: product.id, project_id: project.id }])
    end

    it 'returns an order for the staff member', :show_in_doc do
      get "/staff/#{Staff.all.first.id}/orders/#{@order.id}"
      expect(response.body).to eq(@order.to_json(include: %w(order_items)))
    end

    it 'returns an error when the order does not exist' do
      get "/staff/#{Staff.all.first.id}/orders/#{@order.id + 999}"
      expect(response.status).to eq(404)
      expect(json).to eq('error' => 'Not found.')
    end

    it 'returns an error when the staff member does not exist' do
      get "/staff/#{Staff.all.first.id + 999}/orders/#{@order.id}"
      expect(response.status).to eq(404)
      expect(json).to eq('error' => 'Not found.')
    end
  end

  describe 'GET index' do
    before(:each) do
      sign_in_as create :staff, :admin
      Order.create(staff_id: Staff.all.first.id, order_items_attributes: [{ product_id: product.id, project_id: project.id }, { product_id: product.id, project_id: project.id }])
      @orders = Order.all
    end

    it 'returns orders', :show_in_doc do
      get "/staff/#{Staff.all.first.id}/orders"
      expect(response.body).to eq(@orders.to_json(include: %w(order_items)))
    end

    it 'returns an error when the staff member does not exist' do
      get "/staff/#{Staff.all.first.id + 999}/orders"
      expect(response.status).to eq(404)
      expect(json).to eq('error' => 'Not found.')
    end

    it 'paginates the staff_orders' do
      get "/staff/#{Staff.all.first.id}/orders", page: 1, per_page: 1
      expect(json.length).to eq(1)
    end
  end
end
