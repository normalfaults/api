require 'rails_helper'

RSpec.describe 'Staff API' do

  describe 'GET index' do
    before(:each) do
      create :staff
      create :staff, :user
      sign_in_as create :staff, :admin
    end

    it 'returns a collection of all staff' do
      get '/staff'
      expect(json.length).to eq(3)
    end
  end

  describe 'GET show' do
    before(:each) do
      @staff = create :staff
      sign_in_as @staff
    end

    it 'retrieves staff by id' do
      get "/staff/#{@staff.id}"
      expect(json['first_name']).to eq(@staff.first_name)
    end

    it 'returns an error when the staff does not exist' do
      get "/staff/#{@staff.id + 999}"
      expect(response.status).to eq(404)
      expect(json).to eq('error' => 'Not found.')
    end
  end

  describe 'POST create' do
    before(:each) do
      sign_in_as create :staff, :admin
    end

    it 'creates a new staff record' do
      staff_data = { first_name: 'Created', last_name: 'User', email: 'created@test.com', role: 'user', password: 'created_pass', password_confirmation: 'created_pass' }
      post '/staff', staff: staff_data
      expect(json['first_name']).to eq(staff_data[:first_name])
    end

    it 'returns an error if the staff data is missing' do
      post '/staff'
      expect(response.status).to eq(422)
      expect(json).to eq('error' => 'param is missing or the value is empty: staff')
    end
  end

  describe 'PUT update' do
    before(:each) do
      @staff = create :staff
      sign_in_as create :staff, :admin
    end

    it 'changes existing staff' do
      put "/staff/#{@staff.id}", staff: { first_name: 'Updated' }
      expect(response.status).to eq(204)
    end

    it 'returns an error if the staff parameter is missing' do
      put "/staff/#{@staff.id}"
      expect(response.status).to eq(422)
      expect(json).to eq('error' => 'param is missing or the value is empty: staff')
    end

    it 'returns an error when the staff does not exist' do
      put "/staff/#{@staff.id + 999}", staff: { first_name: 'Updated' }
      expect(response.status).to eq(404)
      expect(json).to eq('error' => 'Not found.')
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

      it 'retrieves a list of related projects' do
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

      it 'adds related project' do
        post "/staff/#{@staff.id}/projects", project_id: @project.id
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

      it 'removes related project' do
        delete "/staff/#{@staff.id}/projects", project_id: @project.id
        expect(response.status).to eq(204)
      end
    end
  end
end
