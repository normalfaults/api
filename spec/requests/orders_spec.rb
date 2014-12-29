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
      put "/orders/#{@order.id}", order: { staff_id: Staff.all.first.id, options: ['test'] }
      expect(json['options']).to eq(['test'])
    end

    it 'returns an error if the order parameter is missing' do
      put "/orders/#{@order.id}"
      expect(response.status).to eq(422)
      expect(json).to eq('error' => 'param is missing or the value is empty: order')
    end

    it 'returns an error when the order does not exist' do
      put "/orders/#{@order.id + 999}", order: { options: ['test']  }
      expect(response.status).to eq(404)
      expect(json).to eq('error' => 'Not found.')
    end
  end

  describe 'POST create' do
    before :each do
      sign_in_as create :staff, :admin
    end

    it 'creates an order', :show_in_doc do
      post '/orders/', order: { staff_id: Staff.all.first.id, options: ['test'] }
      expect(response.body).to eq(Order.first.to_json)
    end

    it 'returns an error if the order is missing' do
      post '/orders/'
      expect(response.status).to eq(422)
      expect(json).to eq('error' => 'param is missing or the value is empty: order')
    end
  end

  describe 'DELETE destroy' do
    before :each do
      @order = create :order
      sign_in_as create :staff, :admin
    end

    it 'removes the order', :show_in_doc do
      delete "/orders/#{@order.id}"
      expect(response.status).to eq(200)
    end

    it 'returns an error when the order does not exist' do
      delete "/orders/#{@order.id + 999}"
      expect(response.status).to eq(404)
      expect(json).to eq('error' => 'Not found.')
    end
  end
end
