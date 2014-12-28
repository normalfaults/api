require 'rails_helper'

RSpec.describe 'Staff Orders API' do
  let(:default_params) { { format: :json } }
  let(:project) { create :project }
  let(:product) { create :product }

  describe 'GET show' do
    before(:each) do
      sign_in_as create :staff, :admin
      @order = Order.create_with_items(staff_id: Staff.all.first.id, project_id: project.id, order_items: [{ product_id: product.id }, { product_id: product.id }])
    end

    it 'returns an order for the staff member', :show_in_doc do
      get "/staff/#{Staff.all.first.id}/orders/#{@order.id}"
      expect(response.body).to eq(@order.to_json)
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
      Order.create_with_items(staff_id: Staff.all.first.id, project_id: project.id, order_items: [{ product_id: product.id }, { product_id: product.id }])
      @orders = Order.all
    end

    it 'returns orders', :show_in_doc do
      get "/staff/#{Staff.all.first.id}/orders"
      expect(response.body).to eq(@orders.to_json)
    end

    it 'returns an error when the staff member does not exist' do
      get "/staff/#{Staff.all.first.id + 999}/orders"
      expect(response.status).to eq(404)
      expect(json).to eq('error' => 'Not found.')
    end
  end
end