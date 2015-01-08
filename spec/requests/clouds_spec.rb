require 'rails_helper'

RSpec.describe 'Clouds API' do
  let(:default_params) { { format: :json } }

  describe 'GET index' do
    before(:each) do
      create :cloud
      create :cloud
      sign_in_as create :staff, :admin
      @clouds = Cloud.all
    end

    it 'returns a collection of all of the clouds' do
      get '/clouds'
      expect(response.body).to eq(@clouds.to_json)
    end

    it 'returns a collection of clouds w/ chargebacks', :show_in_doc do
      get '/clouds', includes: [:chargebacks]
      expect(json[0]['chargebacks']).to_not eq(nil)
    end

    it 'returns a collection of clouds w/ products' do
      get '/clouds', includes: [:products]

      expect(json[0]['products']).to_not eq(nil)
    end
  end

  describe 'GET show' do
    before(:each) do
      create :cloud
      sign_in_as create :staff, :admin
      @cloud = Cloud.first
    end

    it 'returns an cloud', :show_in_doc do
      get "/clouds/#{@cloud.id}"
      expect(response.body).to eq(@cloud.to_json)
    end

    it 'returns an error when the cloud does not exist' do
      get "/clouds/#{@cloud.id + 999}"
      expect(response.status).to eq(404)
      expect(JSON(response.body)).to eq('error' => 'Not found.')
    end

    it 'returns a cloud w/ chargebacks'do
      get "/clouds/#{@cloud.id}", includes: [:chargebacks]
      expect(json['chargebacks']).to_not eq(nil)
    end

    it 'returns a cloud w/ products' do
      get "/clouds/#{@cloud.id}", includes: [:products]
      expect(json['products']).to_not eq(nil)
    end
  end

  describe 'PUT update' do
    before(:each) do
      create :cloud
      sign_in_as create :staff, :admin
      @cloud = Cloud.first
    end

    it 'updates a cloud', :show_in_doc do
      put "/clouds/#{@cloud.id}", name: 'test'
      expect(response.status).to eq(204)
    end

    it 'returns an error when the cloud does not exist' do
      put "/clouds/#{@cloud.id + 999}", hourly_price: '9'
      expect(response.status).to eq(404)
      expect(JSON(response.body)).to eq('error' => 'Not found.')
    end
  end

  describe 'POST create' do
    before(:each) do
      sign_in_as create :staff, :admin
    end

    it 'creates an cloud', :show_in_doc do
      post '/clouds/', name: 'test'
      expect(response.body).to eq(Cloud.first.to_json)
    end
  end

  describe 'DELETE destroy' do
    before :each do
      sign_in_as create :staff, :admin
      @cloud = create :cloud
    end

    it 'removes the cloud', :show_in_doc do
      delete "/clouds/#{@cloud.id}"
      expect(response.status).to eq(204)
    end

    it 'returns an error when the cloud does not exist' do
      delete "/clouds/#{@cloud.id + 999}"
      expect(response.status).to eq(404)
      expect(JSON(response.body)).to eq('error' => 'Not found.')
    end
  end
end
