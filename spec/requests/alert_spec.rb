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
      create :alert, :active
      create :alert, :inactive
      get '/alerts/all'
      expect(json.length).to eq(6)
      true
    end
  end

  describe 'GET show' do
    before :each  do
      @active_alert = create :alert, :active
      @inactive_alert = create :alert, :inactive
      sign_in_as create :staff, :admin
    end

    it 'retrieves alert by id', :show_in_doc do
      get "/alerts/#{@active_alert.id}"
      expect(json['id']).to eq(@active_alert.id)
    end

    it 'verifies show alerts, default behavior show active', :show_in_doc do
      get '/alerts'
      expect(json.length).to eq(1)
    end

    it 'verifies show all alerts', :show_in_doc do
      get '/alerts/all'
      expect(json.length).to eq(2)
    end

    it 'verifies show active alerts', :show_in_doc do
      get '/alerts/active'
      expect(json.length).to eq(1)
    end

    it 'verifies show inactive alerts', :show_in_doc do
      get '/alerts/inactive'
      expect(json.length).to eq(1)
    end

    it 'returns an error when the alert does not exist' do
      get "/alerts/#{@active_alert.id + 999}"
      expect(response.status).to eq(404)
      expect(json).to eq('error' => 'Not found.')
    end
  end

  describe 'POST create' do
    before :each do
      sign_in_as create :staff, :admin
    end

    it 'creates a new alert', :show_in_doc do
      alert_data = { project_id: '0', staff_id: '0', order_id: '0', status: 'OK', message: 'This is a test' }
      post '/alerts', alert_data
      expect(json['message']).to eq(alert_data[:message])
    end

    it 'verifies creation of a new sensu alert', :show_in_doc do
      alert_data = { hostname: 'foo.bar.com', port: '5000', service: 'postgresql', status: 'OK', message: 'This is a test', event: 'tbd' }
      post '/alerts/sensu', alert_data
      expect(json['message']).to eq(alert_data[:message])
    end

    it 'verifies update alert on duplicate insert', :show_in_doc do
      alert_data = { project_id: '0', staff_id: '0', order_id: '0', status: 'OK', message: 'This is a test' }
      post '/alerts', alert_data
      original_id = json['id']
      expect(json['message']).to eq(alert_data[:message])
      alert_data = { project_id: '0', staff_id: '0', order_id: '0', status: 'OK', message: 'This is a test' }
      post '/alerts', alert_data
      expect(json['id']).to eq(original_id)
    end

    it 'returns an error if the alert data is missing' do
      post '/alerts'
      expect(response.status).to eq(422)
      expect(json).to eq('error' => 'param is missing or the value is empty: project_id')
    end

    it 'verifies alerts are only created for a new service status and updated otherwise.', :show_in_doc do
      # TIMESTAMP: N
      alert_data = { project_id: '1', staff_id: '2', order_id: '3', status: 'OK', message: 'NO ISSUES.' }
      post '/alerts', alert_data
      # TIMESTAMP: N + 1
      alert_data = { project_id: '1', staff_id: '2', order_id: '3', status: 'OK', message: 'NO ISSUES.' }
      post '/alerts', alert_data
      # TIMESTAMP: N + 2
      alert_data = { project_id: '1', staff_id: '2', order_id: '3', status: 'CRITICAL', message: 'FIX ME!' }
      post '/alerts', alert_data
      # TIMESTAMP: N + 3
      alert_data = { project_id: '1', staff_id: '2', order_id: '3', status: 'CRITICAL', message: 'STILL BROKEN!' }
      post '/alerts', alert_data
      # TIMESTAMP: N + 4
      alert_data = { project_id: '1', staff_id: '2', order_id: '3', status: 'OK', message: 'NO ISSUES.' }
      post '/alerts', alert_data
      # TIMESTAMP: N + 5
      alert_data = { project_id: '1', staff_id: '2', order_id: '3', status: 'WARNING', message: 'REVIEW LOGS.' }
      post '/alerts', alert_data
      # VERIFY CREATE/UPDATE LOGIC IS WORKING
      get '/alerts/all'
      json = JSON.parse(response.body)
      expect(json.length).to eq(4)
    end
  end

  describe 'PUT update' do
    before :each do
      @alert = create :alert
      sign_in_as create :staff, :admin
    end

    it 'changes existing alert message', :show_in_doc do
      params = {}
      params[:project_id] = @alert.project_id
      params[:staff_id] = @alert.staff_id
      params[:order_id] = @alert.order_id
      params[:status] = @alert.status
      params[:message] = 'Updated'
      put "/alerts/#{@alert.id}", params
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
