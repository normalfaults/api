require 'rails_helper'

RSpec.describe 'Orders API' do
  let(:default_params) { { format: :json } }

  describe 'GET index' do
    before(:each) do
      @order1 = create :order
      @order2 = create :order
      sign_in_as create :staff, :admin
      @orders = Order.all
    end

    it 'returns a collection of all of the orders w/ items', :show_in_doc do
      get '/orders'
      expect(response.body).to eq(@orders.as_json(include: [:order_items]).to_json)
    end

    it 'paginates the orders' do
      get '/orders', page: 1, per_page: 1
      expect(json.length).to eq(1)
    end
  end

  describe 'GET show' do
    before(:each) do
      create :order
      sign_in_as create :staff, :admin
      @order = Order.first
    end

    it 'returns an order', :show_in_doc do
      get "/orders/#{@order.id}"
      expect(response.body).to eq(@order.as_json(include: [:order_items]).to_json)
    end

    it 'returns an error when the order does not exist' do
      get "/orders/#{@order.id + 999}"
      expect(response.status).to eq(404)
      expect(json).to eq('error' => 'Not found.')
    end
  end

  describe 'PUT update' do
    before(:each) do
      create :order
      sign_in_as create :staff, :admin
      @order = Order.first
    end

    it 'updates a order', :show_in_doc do
      put "/orders/#{@order.id}", staff_id: Staff.all.first.id, options: ['test']
      expect(response.status).to eq(204)
    end

    it 'returns an error when the order does not exist' do
      put "/orders/#{@order.id + 999}", options: ['test']
      expect(response.status).to eq(404)
      expect(json).to eq('error' => 'Not found.')
    end
  end

  describe 'POST create' do
    before :each do
      sign_in_as create :staff, :admin
    end

    it 'creates an order', :show_in_doc do
      post '/orders/', staff_id: Staff.all.first.id, options: ['test']
      expect(response.body).to eq(Order.first.to_json)
    end
  end

  describe 'DELETE destroy' do
    before :each do
      @order = create :order
      sign_in_as create :staff, :admin
    end

    it 'removes the order', :show_in_doc do
      delete "/orders/#{@order.id}"
      expect(response.status).to eq(204)
    end

    it 'returns an error when the order does not exist' do
      delete "/orders/#{@order.id + 999}"
      expect(response.status).to eq(404)
      expect(json).to eq('error' => 'Not found.')
    end
  end

  context 'Items' do

    describe 'GET /orders/:id/items' do
      before :each do
        @order = create :order, :with_items
        sign_in_as create :staff, :admin
      end

      it 'returns a list of items' do
        get "/orders/#{@order.id}/items"
        expect(json.length).to eq(2)
      end
    end
  end
end
