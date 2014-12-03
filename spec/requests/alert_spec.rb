require 'rails_helper'

RSpec.describe 'Alerts API' do
  let(:default_params) { { format: :json } }

  describe 'GET index' do
    before :each do
      sign_in_as create :staff, :admin
    end

    it 'returns a collection of all alerts', :show_in_doc do
      create :alert
      create :alert, :first
      create :alert, :second
      create :alert, :third
      get '/alerts'
      expect(json.length).to eq(4)
      true
    end

  end

  describe 'GET show' do
    before :each  do
      @alert = create :alert
      sign_in_as create :staff, :admin
    end

    it 'retrieves alert by id', :show_in_doc do
      get "/alerts/#{@alert.id}"
      expect(json['id']).to eq(@alert.id)
    end

    it 'returns an error when the alert does not exist' do
      get "/alerts/#{@alert.id + 999}"
      expect(response.status).to eq(404)
      expect(json).to eq('error' => 'Not found.')
    end

  end

  describe 'POST create' do
    before :each do
      sign_in_as create :staff, :admin
    end

    it 'creates a new alert', :show_in_doc do
      alert_data = { project_id: '0', staff_id: '0', status: 'OK', message: 'This is a test' }
      post '/alerts', alert_data
      expect(json['message']).to eq(alert_data[:message])
    end

    it 'returns an error if the alert data is missing' do
      post '/alerts'
      expect(response.status).to eq(422)
      expect(json).to eq('error' => 'param is missing or the value is empty: project_id')
    end
  end

  describe 'PUT update' do
    before :each do
      @alert = create :alert
      sign_in_as create :staff, :admin
    end

    it 'changes existing alert message', :show_in_doc do
      put "/alerts/#{@alert.id}", message: 'Updated'
      expect(response.status).to eq(204)
    end

    it 'returns an error when the setting does not exist' do
      put "/alerts/#{@alert.id + 999}", message: 'Updated'
      expect(response.status).to eq(404)
      expect(json).to eq('error' => 'Not found.')
    end
  end

  describe 'DELETE destroy' do
    before :each do
      @alert = create :alert
      sign_in_as create :staff, :admin
    end

    it 'verifies a setting no longer exists after delete', :show_in_doc do
      delete "/alerts/#{@alert.id}"
      expect(response.status).to eq(204)
      get "/alerts/#{@alert.id}"
      expect(json).to eq('error' => 'Not found.')
    end
  end
end
