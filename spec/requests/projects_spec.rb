require 'rails_helper'

RSpec.describe 'Projects API' do

  describe 'GET index' do
    before :each do
      create :project
      create :project
      sign_in_as create :staff, :admin
    end

    it 'returns a collection of all projects' do
      get '/projects'
      expect(json.length).to eq(2)
    end
  end

  describe 'GET show' do
    before :each  do
      @project = create :project
      sign_in_as create :staff, :admin
    end

    it 'retrieves project by id' do
      get "/projects/#{@project.id}"
      expect(json['name']).to eq(@project.name)
    end

    it 'returns an error when the project does not exist' do
      get "/projects/#{@project.id + 999}"
      expect(response.status).to eq(404)
      expect(json).to eq('error' => 'Not found.')
    end
  end

  describe 'POST create' do
    before :each do
      sign_in_as create :staff, :admin
    end

    it 'creates a new project record' do
      project_data = { name: 'Created', description: 'description', cc: 'cc', staff_id: 'staff_id', budget: 1, start_date: DateTime.now.to_date, end_date: DateTime.now.to_date + 1.week, approved: 'Y', img: 'img' }
      post '/projects', project: project_data
      expect(json['name']).to eq(project_data[:name])
    end

    it 'returns an error if the project data is missing' do
      post '/projects'
      expect(response.status).to eq(422)
      expect(json).to eq('error' => 'param is missing or the value is empty: project')
    end
  end

  describe 'PUT update' do
    before :each do
      @project = create :project
      sign_in_as create :staff, :admin
    end

    it 'changes existing project' do
      put "/projects/#{@project.id}", project: { name: 'Updated' }
      expect(response.status).to eq(204)
    end

    it 'returns an error if the project data is missing' do
      put "/projects/#{@project.id}"
      expect(response.status).to eq(422)
      expect(json).to eq('error' => 'param is missing or the value is empty: project')
    end

    it 'returns an error when the project does not exist' do
      put "/projects/#{@project.id + 999}", project: { name: 'Updated' }
      expect(response.status).to eq(404)
      expect(json).to eq('error' => 'Not found.')
    end
  end

  context 'Staff' do
    describe 'GET' do
      before :each do
        @staff = create :staff, :user
        @project = create :project
        @project.staff << @staff
        sign_in_as create :staff, :admin
      end

      it 'retrieves a list of related staff' do
        get "/projects/#{@project.id}/staff"
        expect(response.status).to eq(200)
        expect(json.length).to eq(1)
      end
    end

    describe 'POST' do
      before :each do
        @staff = create :staff, :user
        @project = create :project
        sign_in_as create :staff, :admin
      end

      it 'adds related staff' do
        post "/projects/#{@project.id}/staff/#{@staff.id}"
        expect(response.status).to eq(201)
        expect(json['first_name']).to eq(@staff.first_name)
      end
    end

    describe 'DELETE' do
      before :each do
        @staff = create :staff, :user
        @project = create :project
        @project.staff << @staff
        sign_in_as create :staff, :admin
      end

      it 'removes related staff' do
        delete "/projects/#{@project.id}/staff/#{@staff.id}"
        expect(response.status).to eq(204)
      end
    end
  end
end
