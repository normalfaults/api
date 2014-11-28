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

      get '/chargebacks', include: ['cloud']
      expect(json[0]['cloud']).to_not eq(nil)
    end

    it 'returns a collection of all of the chargebacks w/ products', :show_in_doc do
      product = create :product
      @chargeback1.update_attributes(product_id: product.id)
      @chargeback2.update_attributes(product_id: product.id)

      get '/chargebacks', include: ['product']
      expect(json[0]['product']).to_not eq(nil)
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

      get "/chargebacks/#{@chargeback.id}", include: ['cloud']
      expect(json['cloud']).to_not eq(nil)
    end

    it 'returns an chargeback w/ a product', :show_in_doc do
      product = create :product
      @chargeback.update_attributes(product_id: product.id)

      get "/chargebacks/#{@chargeback.id}", include: ['product']
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
      put "/chargebacks/#{@chargeback.id}", chargeback: { cloud_id: 1 }
      expect(JSON(response.body)['cloud_id']).to eq(1)
    end

    it 'returns an error if the chargeback parameter is missing' do
      put "/chargebacks/#{@chargeback.id}"
      expect(response.status).to eq(422)
      expect(JSON(response.body)).to eq('error' => 'param is missing or the value is empty: chargeback')
    end

    it 'returns an error when the chargeback does not exist' do
      put "/chargebacks/#{@chargeback.id + 999}", chargeback: { hourly_price: '9' }
      expect(response.status).to eq(404)
      expect(JSON(response.body)).to eq('error' => 'Not found.')
    end
  end

  describe 'POST create' do
    before(:each) do
      sign_in_as create :staff, :admin
    end

    it 'creates an chargeback', :show_in_doc do
      post '/chargebacks/', chargeback: { hourly_price: '9' }
      expect(response.body).to eq(Chargeback.first.to_json)
    end

    it 'returns an error if the chargeback is missing' do
      post '/chargebacks/'
      expect(response.status).to eq(422)
      expect(JSON(response.body)).to eq('error' => 'param is missing or the value is empty: chargeback')
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
