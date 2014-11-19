require 'rails_helper'

RSpec.describe 'Products API' do
  describe 'GET index' do
    before(:each) do
      create :product
      create :product
      @products = Product.all
    end

    it 'returns a collection of all of the products' do
      get '/products'
      expect(response.body).to eq(@products.to_json)
    end
  end

  describe 'GET show' do
    before(:each) do
      create :product
      @product = Product.first
    end

    it 'returns an product' do
      get "/products/#{@product.id}"
      expect(response.body).to eq(@product.to_json)
    end

    it 'returns an error when the product does not exist' do
      get "/products/#{@product.id + 999}"
      expect(response.status).to eq(404)
      expect(JSON(response.body)).to eq('error' => 'Not found.')
    end
  end

  describe 'PUT update' do
    before(:each) do
      create :product
      @product = Product.first
    end

    it 'updates a product' do
      put "/products/#{@product.id}", product: { options: ['test'] }
      expect(JSON(response.body)['options']).to eq(['test'])
    end

    it 'returns an error if the product parameter is missing' do
      put "/products/#{@product.id}"
      expect(response.status).to eq(422)
      expect(JSON(response.body)).to eq('error' => 'param is missing or the value is empty: product')
    end

    it 'returns an error when the product does not exist' do
      put "/products/#{@product.id + 999}", product: { options: ['test']  }
      expect(response.status).to eq(404)
      expect(JSON(response.body)).to eq('error' => 'Not found.')
    end
  end

  describe 'POST create' do
    it 'creates an product' do
      post '/products/', product: { options: ['test'] }
      expect(response.body).to eq(Product.first.to_json)
    end

    it 'returns an error if the product is missing' do
      post '/products/'
      expect(response.status).to eq(422)
      expect(JSON(response.body)).to eq('error' => 'param is missing or the value is empty: product')
    end
  end

  describe 'DELETE destroy' do
    before :each do
      @product = create :product
    end

    it 'removes the product' do
      delete "/products/#{@product.id}"
      expect(response.status).to eq(200)
    end

    it 'returns an error when the product does not exist' do
      delete "/products/#{@product.id + 999}"
      expect(response.status).to eq(404)
      expect(JSON(response.body)).to eq('error' => 'Not found.')
    end
  end
end
