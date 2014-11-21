require 'rails_helper'

RSpec.describe 'Orders API' do
  describe 'GET index' do
    before(:each) do
      create :order
      create :order
      @orders = Order.all
    end

    it 'returns a collection of all of the orders', :show_in_doc do
      get '/orders'
      expect(response.body).to eq(@orders.to_json)
    end
  end

  describe 'GET show' do
    before(:each) do
      create :order
      @order = Order.first
    end

    it 'returns an order', :show_in_doc do
      get "/orders/#{@order.id}"
      expect(response.body).to eq(@order.to_json)
    end

    it 'returns an error when the order does not exist' do
      get "/orders/#{@order.id + 999}"
      expect(response.status).to eq(404)
      expect(JSON(response.body)).to eq('error' => 'Not found.')
    end
  end

  describe 'PUT update' do
    before(:each) do
      create :order
      @order = Order.first
    end

    it 'updates a order', :show_in_doc do
      put "/orders/#{@order.id}", order: { options: ['test'] }
      expect(JSON(response.body)['options']).to eq(['test'])
    end

    it 'returns an error if the order parameter is missing' do
      put "/orders/#{@order.id}"
      expect(response.status).to eq(422)
      expect(JSON(response.body)).to eq('error' => 'param is missing or the value is empty: order')
    end

    it 'returns an error when the order does not exist' do
      put "/orders/#{@order.id + 999}", order: { options: ['test']  }
      expect(response.status).to eq(404)
      expect(JSON(response.body)).to eq('error' => 'Not found.')
    end
  end

  describe 'POST create' do
    it 'creates an order', :show_in_doc do
      post '/orders/', order: { product_id: 1, project_id: 1, staff_id: 1, cloud_id: 1, options: ['test'] }
      expect(response.body).to eq(Order.first.to_json)
    end

    it 'returns an error if the order is missing' do
      post '/orders/'
      expect(response.status).to eq(422)
      expect(JSON(response.body)).to eq('error' => 'param is missing or the value is empty: order')
    end
  end

  describe 'DELETE destroy' do
    before :each do
      @order = create :order
    end

    it 'removes the product', :show_in_doc do
      delete "/orders/#{@order.id}"
      expect(response.status).to eq(200)
    end

    it 'returns an error when the product does not exist' do
      delete "/orders/#{@order.id + 999}"
      expect(response.status).to eq(404)
      expect(JSON(response.body)).to eq('error' => 'Not found.')
    end
  end
end
