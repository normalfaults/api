require 'rails_helper'

RSpec.describe 'Products API' do
  let(:default_params) { { format: :json } }

  describe 'GET index' do
    before(:each) do
      create :product
      create :product
      @products = Product.all
    end

    it 'returns a collection of all of the products', :show_in_doc do
      get '/products'
      expect(json.to_json).to eq(@products.to_json)
    end

    it 'returns a collection of all of the products w/ chargebacks' do
      get '/products', includes: %w(chargebacks)
      expect(json[0]['chargebacks']).to_not eq(nil)
    end
  end

  describe 'GET show' do
    before(:each) do
      create :product
      @product = Product.first
    end

    it 'returns an product', :show_in_doc do
      get "/products/#{@product.id}"
      expect(response.body).to eq(@product.to_json)
    end

    it 'returns an product w/ chargebacks' do
      get "/products/#{@product.id}", includes: %w(chargebacks)
      expect(json['chargebacks']).to_not eq(nil)
    end

    it 'returns an error when the product does not exist' do
      get "/products/#{@product.id + 999}"
      expect(response.status).to eq(404)
      expect(json).to eq('error' => 'Not found.')
    end
  end

  describe 'PUT update' do
    before(:each) do
      create :product
      @product = Product.first
    end

    it 'updates a product', :show_in_doc do
      put "/products/#{@product.id}", options: ['test']
      expect(json['options']).to eq(['test'])
    end

    it 'returns an error when the product does not exist' do
      put "/products/#{@product.id + 999}", options: ['test']
      expect(response.status).to eq(404)
      expect(json).to eq('error' => 'Not found.')
    end
  end

  describe 'POST create' do
    it 'creates an product', :show_in_doc do
      post '/products/', options: ['test']
      expect(response.body).to eq(Product.first.to_json)
    end
  end

  describe 'DELETE destroy' do
    before :each do
      @product = create :product
    end

    it 'removes the product', :show_in_doc do
      delete "/products/#{@product.id}"
      expect(response.status).to eq(200)
    end

    it 'returns an error when the product does not exist' do
      delete "/products/#{@product.id + 999}"
      expect(response.status).to eq(404)
      expect(json).to eq('error' => 'Not found.')
    end
  end
end
