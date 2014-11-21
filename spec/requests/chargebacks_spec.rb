require 'rails_helper'

RSpec.describe 'Chargebacks API' do
  describe 'GET index' do
    before(:each) do
      create :chargeback
      create :chargeback
      @chargebacks = Chargeback.all
    end

    it 'returns a collection of all of the chargebacks', :show_in_doc do
      get '/chargebacks'
      expect(response.body).to eq(@chargebacks.to_json)
    end
  end

  describe 'GET show' do
    before(:each) do
      create :chargeback
      @chargeback = Chargeback.first
    end

    it 'returns an chargeback', :show_in_doc do
      get "/chargebacks/#{@chargeback.id}"
      expect(response.body).to eq(@chargeback.to_json)
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

    it 'returns an error when the order does not exist' do
      put "/chargebacks/#{@chargeback.id + 999}", chargeback: { hourly_price: '9' }
      expect(response.status).to eq(404)
      expect(JSON(response.body)).to eq('error' => 'Not found.')
    end
  end

  describe 'POST create' do
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
