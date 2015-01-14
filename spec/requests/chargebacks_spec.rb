require 'rails_helper'

RSpec.describe 'Chargebacks API' do
  let(:default_params) { { format: :json } }

  describe 'GET index' do
    before(:each) do
      @chargeback1 = create :chargeback
      @chargeback2 = create :chargeback
      sign_in_as create :staff, :admin
      @chargebacks = Chargeback.all
    end

    it 'returns a collection of all of the chargebacks', :show_in_doc do
      get '/chargebacks'
      expect(response.body).to eq(@chargebacks.to_json)
    end

    it 'returns a collection of all of the chargebacks w/ coulds', :show_in_doc do
      cloud = create :cloud
      @chargeback1.update_attributes(cloud_id: cloud.id)
      @chargeback2.update_attributes(cloud_id: cloud.id)

      get '/chargebacks', includes: ['cloud']
      expect(json[0]['cloud']).to_not eq(nil)
    end

    it 'returns a collection of all of the chargebacks w/ products', :show_in_doc do
      product = create :product
      @chargeback1.update_attributes(product_id: product.id)
      @chargeback2.update_attributes(product_id: product.id)

      get '/chargebacks', includes: ['product']
      expect(json[0]['product']).to_not eq(nil)
    end

    it 'paginates the chargebacks' do
      get '/chargebacks', page: 1, per_page: 1
      expect(json.length).to eq(1)
    end
  end

  describe 'GET show' do
    before(:each) do
      create :chargeback
      sign_in_as create :staff, :admin
      @chargeback = Chargeback.first
    end

    it 'returns an chargeback', :show_in_doc do
      get "/chargebacks/#{@chargeback.id}"
      expect(response.body).to eq(@chargeback.to_json)
    end

    it 'returns an chargeback w/ a cloud', :show_in_doc do
      cloud = create :cloud
      @chargeback.update_attributes(cloud_id: cloud.id)

      get "/chargebacks/#{@chargeback.id}", includes: ['cloud']
      expect(json['cloud']).to_not eq(nil)
    end

    it 'returns an chargeback w/ a product', :show_in_doc do
      product = create :product
      @chargeback.update_attributes(product_id: product.id)

      get "/chargebacks/#{@chargeback.id}", includes: ['product']
      expect(json['product']).to_not eq(nil)
    end

    it 'returns an error when the chargeback does not exist' do
      get "/chargebacks/#{@chargeback.id + 999}"
      expect(response.status).to eq(404)
      expect(JSON(response.body)).to eq('error' => 'Not found.')
    end
  end

  describe 'PUT update' do
    before(:each) do
      create :chargeback
      sign_in_as create :staff, :admin
      @chargeback = Chargeback.first
    end

    it 'updates a chargeback', :show_in_doc do
      put "/chargebacks/#{@chargeback.id}", cloud_id: 1
      expect(response.status).to eq(204)
    end

    it 'returns an error when the chargeback does not exist' do
      put "/chargebacks/#{@chargeback.id + 999}", hourly_price: '9'
      expect(response.status).to eq(404)
      expect(JSON(response.body)).to eq('error' => 'Not found.')
    end
  end

  describe 'POST create' do
    before(:each) do
      sign_in_as create :staff, :admin
    end

    it 'creates an chargeback', :show_in_doc do
      post '/chargebacks/', hourly_price: '9'
      expect(response.body).to eq(Chargeback.first.to_json)
    end
  end

  describe 'DELETE destroy' do
    before :each do
      sign_in_as create :staff, :admin
      @chargeback = create :chargeback
    end

    it 'removes the chargeback', :show_in_doc do
      delete "/chargebacks/#{@chargeback.id}"
      expect(response.status).to eq(204)
    end

    it 'returns an error when the chargeback does not exist' do
      delete "/chargebacks/#{@chargeback.id + 999}"
      expect(response.status).to eq(404)
      expect(JSON(response.body)).to eq('error' => 'Not found.')
    end
  end
end
