require 'rails_helper'

RSpec.describe 'Alerts API' do
  let(:default_params) { { format: :json } }

  describe 'GET index' do
    before :each do
      sign_in_as create :staff, :admin
      create :alert
      create :alert, :first
      create :alert, :second
      create :alert, :third
      create :alert, :inactive
      create :alert, :active
    end

    it 'returns a collection of all alerts', :show_in_doc do
      get '/alerts'
      expect(json.length).to eq(6)
    end

    it 'paginates the alerts' do
      get '/alerts', page: 1, per_page: 5
      expect(json.length).to eq(5)
    end
  end

  describe 'GET show (as Admin)' do
    before :each  do
      @active_alert = create :alert, :active, status: 'OK'
      create :alert, :inactive, status: 'OK'
      create :alert, :active, status: 'OK'
      create :alert, :active, status: 'WARNING'
      create :alert, :active, status: 'CRITICAL'
      create :alert, :inactive, status: 'OK'
      create :alert, :inactive, status: 'WARNING'
      create :alert, :inactive, status: 'CRITICAL'
      sign_in_as create :staff, :admin
    end

    it 'retrieves alert by id', :show_in_doc do
      get "/alerts/#{@active_alert.id}"
      expect(json['id']).to eq(@active_alert.id)
    end

    it 'shows all alerts', :show_in_doc do
      get '/alerts'
      expect(json.length).to eq(8)
    end

    it 'shows all active alerts', :show_in_doc do
      get '/alerts', active: true
      expect(json.length).to eq(4)
    end

    it 'shows all inactive alerts', :show_in_doc do
      get '/alerts', active: false
      expect(json.length).to eq(4)
    end

    it 'shows all non-OK alerts', :show_in_doc do
      get '/alerts', not_status: ['OK']
      expect(json.length).to eq(4)
    end

    it 'shows all alerts sorted by oldest_first', :show_in_doc do
      get '/alerts', sort: ['oldest_first']
      expect(json.length).to eq(8)
      expect(DateTime.parse(json[0]['updated_at']).to_s).to eq(@active_alert.updated_at.to_datetime.to_s)
    end

    it 'shows all active non-OK alerts', :show_in_doc do
      get '/alerts', active: true, not_status: ['OK']
      expect(json.length).to eq(2)
    end

    it 'returns an error when the alert does not exist' do
      get "/alerts/#{@active_alert.id + 999}"
      expect(response.status).to eq(404)
      expect(json).to eq('error' => 'Not found.')
    end
  end

  describe 'GET show (as Staff)' do
    before :each  do
      staff = create :staff
      project = create :project
      project.staff << staff
      visible_alert = create :alert, :active
      visible_alert.project = project
      visible_alert.save!
      create :alert, :active
      create :alert, :active
      sign_in_as staff
    end

    it 'verifies show alerts, scoped to the user', :show_in_doc do
      get '/alerts'
      expect(json.length).to eq(1)
    end
  end

  describe 'POST create' do
    before :each do
      sign_in_as create :staff, :admin
    end

    it 'creates a new alert', :show_in_doc do
      alert_data = { project_id: '0', staff_id: '0', order_item_id: '0', status: 'OK', message: 'This is a test' }
      post '/alerts', alert_data
      expect(json['message']).to eq(alert_data[:message])
    end

    it 'verifies creation of a new sensu alert', :show_in_doc do
      alert_data = { hostname: 'foo.bar.com', port: '5000', service: 'postgresql', status: 'OK', message: 'This is a test', event: 'tbd' }
      post '/alerts/sensu', alert_data
      expect(json['message']).to eq(alert_data[:message])
    end

    it 'verifies update alert on duplicate insert', :show_in_doc do
      alert_data = { project_id: '0', staff_id: '0', order_item_id: '0', status: 'OK', message: 'This is a test' }
      post '/alerts', alert_data
      original_id = json['id']
      expect(json['message']).to eq(alert_data[:message])
      alert_data = { project_id: '0', staff_id: '0', order_item_id: '0', status: 'OK', message: 'This is a test' }
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
      alert_data = { project_id: '1', staff_id: '2', order_item_id: '3', status: 'OK', message: 'NO ISSUES.' }
      post '/alerts', alert_data
      # TIMESTAMP: N + 1
      alert_data = { project_id: '1', staff_id: '2', order_item_id: '3', status: 'OK', message: 'NO ISSUES.' }
      post '/alerts', alert_data
      # TIMESTAMP: N + 2
      alert_data = { project_id: '1', staff_id: '2', order_item_id: '3', status: 'CRITICAL', message: 'FIX ME!' }
      post '/alerts', alert_data
      # TIMESTAMP: N + 3
      alert_data = { project_id: '1', staff_id: '2', order_item_id: '3', status: 'CRITICAL', message: 'STILL BROKEN!' }
      post '/alerts', alert_data
      # TIMESTAMP: N + 4
      alert_data = { project_id: '1', staff_id: '2', order_item_id: '3', status: 'OK', message: 'NO ISSUES.' }
      post '/alerts', alert_data
      # TIMESTAMP: N + 5
      alert_data = { project_id: '1', staff_id: '2', order_item_id: '3', status: 'WARNING', message: 'REVIEW LOGS.' }
      post '/alerts', alert_data
      # VERIFY CREATE/UPDATE LOGIC IS WORKING
      get '/alerts'
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
      params[:order_item_id] = @alert.order_item_id
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
