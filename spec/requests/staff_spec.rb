require 'rails_helper'

RSpec.describe 'Staff API' do
  let(:default_params) { { format: :json } }

  describe 'GET index' do
    before(:each) do
      create :staff, first_name: 'john', last_name: 'smith', email: 'foo@bar.com'
      create :staff, :user
      sign_in_as create :staff, :admin
    end

    it 'returns a collection of all staff' do
      get '/staff'
      expect(json.length).to eq(3)
    end

    it 'returns a collection of all staff w/ projects', :show_in_doc do
      get '/staff', includes: %w(projects)
      expect(json[0]['projects']).to_not eq(nil)
    end

    it 'returns a collection of all staff w/ user_settings' do
      get '/staff', includes: %w(user_settings)
      expect(json[0]['user_settings']).to_not eq(nil)
    end

    it 'returns a search of all staff using the query' do
      get '/staff', query: 'joh'
      expect(json[0]['first_name']).to eq('john')
    end
  end

  describe 'GET show' do
    before(:each) do
      @staff = create :staff
      sign_in_as @staff
    end

    it 'retrieves staff by id', :show_in_doc do
      get "/staff/#{@staff.id}"
      expect(json['first_name']).to eq(@staff.first_name)
    end

    it 'retrieves staff by id w/ projects', :show_in_doc do
      get "/staff/#{@staff.id}", includes: %w(projects)
      expect(json['projects']).to_not eq(nil)
    end

    it 'retrieves staff by id w/ user_settings', :show_in_doc do
      get "/staff/#{@staff.id}", includes: %w(user_settings)
      expect(json['user_settings']).to_not eq(nil)
    end

    it 'returns an error when the staff does not exist' do
      get "/staff/#{@staff.id + 999}"
      expect(response.status).to eq(404)
      expect(json).to eq('error' => 'Not found.')
    end
  end

  describe 'GET current_member' do
    before(:each) do
      @staff = create :staff
    end

    it 'retrieves the current member for logged in users', :show_in_doc do
      sign_in_as @staff

      get '/staff/current_member'

      expect(json['first_name']).to eq(@staff.first_name)
    end

    it 'retrieves staff w/ notifications' do
      sign_in_as @staff

      get '/staff/current_member', includes: %w(notifications)
      expect(json['notifications']).to_not eq(nil)
    end

    it 'retrieves staff w/ a cart', :show_in_doc do
      create :cart, staff_id: @staff.id
      sign_in_as @staff

      get '/staff/current_member', includes: %w(cart)
      expect(json['cart']).to_not eq(nil)
    end

    it 'returns a 401 when the user is not logged in' do
      get '/staff/current_member'
      expect(response.status).to eq(302)
    end
  end

  describe 'POST create' do
    before(:each) do
      sign_in_as create :staff, :admin
    end

    it 'creates a new staff record', :show_in_doc do
      staff_data = { first_name: 'Created', last_name: 'User', email: 'created@test.com', role: 'user', password: 'created_pass', password_confirmation: 'created_pass' }
      post '/staff', staff_data
      expect(json['first_name']).to eq(staff_data[:first_name])
    end

    it 'returns an error if the staff data is missing' do
      post '/staff'
      expect(response.status).to eq(422)
      expect(json).to eq('errors' => { 'email' => ['can\'t be blank'], 'password' => ['can\'t be blank'] })
    end
  end

  describe 'PUT update' do
    before(:each) do
      @staff = create :staff
      sign_in_as create :staff, :admin
    end

    it 'changes existing staff', :show_in_doc do
      put "/staff/#{@staff.id}", staff: { first_name: 'Updated' }
      expect(response.status).to eq(204)
    end

    it 'returns an error when the staff does not exist' do
      put "/staff/#{@staff.id + 999}", staff: { first_name: 'Updated' }
      expect(response.status).to eq(404)
      expect(json).to eq('error' => 'Not found.')
    end
  end

  context 'User Settings' do
    describe 'GET' do
      before :each do
        @staff = create :staff, :user
        @user_setting = create :user_setting
        @staff.user_settings << @user_setting
        sign_in_as create :staff, :admin
      end

      it 'retrieves a list of user settings', :show_in_doc do
        get "/staff/#{@staff.id}/settings"
        expect(response.status).to eq(200)
      end

      it 'looks up a user setting from id', :show_in_doc do
        get "/staff/#{@staff.id}/settings/#{@user_setting.id}"
        expect(response.status).to eq(200)
        expect(json['name']).to eq(@user_setting.name)
      end
    end

    describe 'POST' do
      before :each do
        @staff = create :staff, :user
        sign_in_as @staff
      end

      it 'adds user setting to staff', :show_in_doc do
        data = { user_setting: { name: 'foo', value: 'bar' } }
        post "/staff/#{@staff.id}/settings", data
        expect(json['name']).to eq(data[:user_setting][:name])
        expect(json['staff_id']).to eq(@staff.id)
      end
    end

    describe 'PUT' do
      before :each do
        @staff = create :staff, :user
        @user_setting = create :user_setting
        @staff.user_settings << @user_setting
        sign_in_as @staff
      end

      it 'updates user setting of staff', :show_in_doc do
        data = { user_setting: { value: 'updated' } }
        put "/staff/#{@staff.id}/settings/#{@user_setting.id}", data
        expect(json['value']).to eq(data[:user_setting][:value])
        expect(response.status).to eq(200)
      end
    end

    describe 'DELETE' do
      before :each do
        @staff = create :staff, :user
        @user_setting = create :user_setting
        @staff.user_settings << @user_setting
        sign_in_as @staff
      end

      it 'removes user setting from staff', :show_in_doc do
        delete "/staff/#{@staff.id}/settings/#{@user_setting.id}"
        expect(response.status).to eq(200)
      end
    end
  end

  context 'Projects' do
    describe 'GET' do
      before :each do
        @project = create :project
        @staff = create :staff, :user
        @staff.projects << @project
        sign_in_as create :staff, :admin
      end

      it 'retrieves a list of related projects', :show_in_doc do
        get "/staff/#{@staff.id}/projects"
        expect(response.status).to eq(200)
        expect(json.length).to eq(1)
      end
    end

    describe 'POST' do
      before :each do
        @project = create :project
        @staff = create :staff, :user
        sign_in_as create :staff, :admin
      end

      it 'adds related project', :show_in_doc do
        post "/staff/#{@staff.id}/projects/#{@project.id}"
        expect(response.status).to eq(201)
        expect(json['name']).to eq(@project.name)
      end
    end

    describe 'DELETE' do
      before :each do
        @project = create :project
        @staff = create :staff, :user
        @staff.projects << @project
        sign_in_as create :staff, :admin
      end

      it 'removes related project', :show_in_doc do
        delete "/staff/#{@staff.id}/projects/#{@project.id}"
        expect(response.status).to eq(204)
      end
    end
  end
end
