require 'rails_helper'

RSpec.describe 'Organizations' do
  describe 'index' do
    before(:each) do
      FactoryGirl.create(:organization)
      FactoryGirl.create(:organization)
      @organizations = Organization.all
    end

    it 'returns a collection of all of the organizations' do
      get '/organizations'
      expect(response.body).to eq(@organizations.to_json)
    end
  end

  describe 'show' do
    before(:each) do
      FactoryGirl.create(:organization)
      @organization = Organization.first
    end

    it 'returns an organization' do
      get "/organizations/#{@organization.id}"
      expect(response.body).to eq(@organization.to_json)
    end

    it 'returns an error when the organization does not exist' do
      get "/organizations/#{@organization.id + 999}"
      expect(response.status).to eq(404)
      expect(JSON(response.body)).to eq('error' => 'Not found.')
    end
  end

  describe 'update' do
    before(:each) do
      FactoryGirl.create(:organization)
      @organization = Organization.first
    end

    it 'updates an organization' do
      put "/organizations/#{@organization.id}", organization: { name: 'some different name' }
      expect(JSON(response.body)['name']).to eq('some different name')
    end

    it 'returns an error if the organization parameter is missing' do
      put "/organizations/#{@organization.id}"
      expect(response.status).to eq(422)
      expect(JSON(response.body)).to eq('error' => 'param is missing or the value is empty: organization')
    end

    it 'returns an error when the organization does not exist' do
      put "/organizations/#{@organization.id + 999}", organization: { name: 'some different name' }
      expect(response.status).to eq(404)
      expect(JSON(response.body)).to eq('error' => 'Not found.')
    end
  end

  describe 'create' do
    it 'creates an organization' do
      post '/organizations/', organization: { name: 'some name', img: 'img.png', desctiption: 'best org ever' }
      expect(response.body).to eq(Organization.first.to_json)
    end

    it 'returns an error if the organization is missing' do
      post '/organizations/'
      expect(response.status).to eq(422)
      expect(JSON(response.body)).to eq('error' => 'param is missing or the value is empty: organization')
    end
  end
end
