require 'rails_helper'

RSpec.describe 'Settings API' do
  let(:default_params) { { format: :json } }

  describe 'GET index' do
    before :each do
      sign_in_as create :staff, :admin
    end

    it 'returns a collection of all global settings', :show_in_doc do
      create :setting, :first
      create :setting, :second
      create :setting, :third
      get '/settings'
      expect(json.length).to eq(3)
    end
  end

  describe 'GET show' do
    before :each  do
      @setting = create :setting
      sign_in_as create :staff, :admin
    end

    it 'retrieves setting by id', :show_in_doc do
      get "/settings/#{@setting.id}"
      expect(json['name']).to eq(@setting.name)
    end

    it 'returns an error when the setting does not exist' do
      get "/settings/#{@setting.id + 999}"
      expect(response.status).to eq(404)
      expect(json).to eq('error' => 'Not found.')
    end
  end

  describe 'POST create' do
    before :each do
      sign_in_as create :staff, :admin
    end

    it 'creates a new setting', :show_in_doc do
      setting_data = { name: 'foo', value: 'bar' }
      post '/settings', setting: setting_data
      expect(json['name']).to eq(setting_data[:name])
    end

    it 'returns an error if the setting data is missing' do
      post '/settings'
      expect(response.status).to eq(422)
      expect(json).to eq('error' => 'param is missing or the value is empty: setting')
    end
  end

  describe 'PUT update' do
    before :each do
      @setting = create :setting
      sign_in_as create :staff, :admin
    end

    it 'changes existing setting value', :show_in_doc do
      put "/settings/#{@setting.id}", setting: { value: 'Updated' }
      expect(response.status).to eq(204)
    end

    it 'returns an error if the setting data is missing' do
      put "/settings/#{@setting.id}"
      expect(response.status).to eq(422)
      expect(json).to eq('error' => 'param is missing or the value is empty: setting')
    end

    it 'returns an error when the setting does not exist' do
      put "/projects/#{@setting.id + 999}", setting: { value: 'Updated' }
      expect(response.status).to eq(404)
      expect(json).to eq('error' => 'Not found.')
    end
  end

  describe 'DELETE destroy' do
    before :each do
      @setting = create :setting
      sign_in_as create :staff, :admin
    end

    it 'verifies a setting no longer exists after delete', :show_in_doc do
      get "/settings/#{@setting.id}"
      expect(json['name']).to eq(@setting.name)
      delete "/settings/#{@setting.id}"
      expect(response.status).to eq(204)
    end
  end
end
