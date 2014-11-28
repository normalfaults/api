require 'rails_helper'

RSpec.describe 'Organizations' do
  let(:default_params) { { format: :json } }

  describe 'GET index' do
    before(:each) do
      create :organization
      create :organization
      @organizations = Organization.all
      sign_in_as create :staff, :admin
    end

    it 'returns a collection of all of the organizations', :show_in_doc do
      get '/organizations'
      expect(response.body).to eq(@organizations.to_json)
    end
  end

  describe 'GET show' do
    before(:each) do
      create :organization
      @organization = Organization.first
      sign_in_as create :staff, :admin
    end

    it 'returns an organization', :show_in_doc do
      get "/organizations/#{@organization.id}"
      expect(response.body).to eq(@organization.to_json)
    end

    it 'returns an error when the organization does not exist' do
      get "/organizations/#{@organization.id + 999}"
      expect(response.status).to eq(404)
      expect(JSON(response.body)).to eq('error' => 'Not found.')
    end
  end

  describe 'PUT update' do
    before(:each) do
      create :organization
      @organization = Organization.first
      sign_in_as create :staff, :admin
    end

    it 'updates an organization', :show_in_doc do
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

  describe 'POST create' do
    before :each do
      sign_in_as create :staff, :admin
    end

    it 'creates an organization', :show_in_doc do
      post '/organizations/', organization: { name: 'some name', img: 'img.png', description: 'best org ever' }
      expect(response.body).to eq(Organization.first.to_json)
    end

    it 'returns an error if the organization is missing' do
      post '/organizations/'
      expect(response.status).to eq(422)
      expect(JSON(response.body)).to eq('error' => 'param is missing or the value is empty: organization')
    end
  end

  describe 'DELETE destroy' do
    before :each do
      @organization = create :organization
      sign_in_as create :staff, :admin
    end

    it 'removes the organization', :show_in_doc do
      delete "/organizations/#{@organization.id}"
      expect(response.status).to eq(200)
    end

    it 'returns an error when the organization does not exist' do
      delete "/organizations/#{@organization.id + 999}", organization: { name: 'some different name' }
      expect(response.status).to eq(404)
      expect(JSON(response.body)).to eq('error' => 'Not found.')
    end
  end
end
