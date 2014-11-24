require 'rails_helper'

RSpec.describe 'Projects API' do

  describe 'GET index' do
    before :each do
      sign_in_as create :staff, :admin
    end

    it 'returns a collection of all projects', :show_in_doc do
      create :project
      create :project
      get '/projects'
      expect(json.length).to eq(2)
    end

    it 'returns a collection of all of the products w/ staff', :show_in_doc do
      project = create :project
      staff = create :staff
      create :staff_project, staff_id: staff.id, project_id: project.id

      get '/projects', include: ['staff']

      expect(json[0]['staff']).to_not eq(nil)
    end
  end

  describe 'GET show' do
    before :each  do
      @project = create :project
      sign_in_as create :staff, :admin
    end

    it 'retrieves project by id', :show_in_doc do
      get "/projects/#{@project.id}"
      expect(json['name']).to eq(@project.name)
    end

    it 'returns an error when the project does not exist' do
      get "/projects/#{@project.id + 999}"
      expect(response.status).to eq(404)
      expect(json).to eq('error' => 'Not found.')
    end

    it 'returns a product w/ staff', :show_in_doc do
      staff = create :staff
      create :staff_project, staff_id: staff.id, project_id: @project.id

      get "/projects/#{@project.id}", include: ['staff']

      expect(json['staff']).to_not eq(nil)
    end

  end

  describe 'POST create' do
    before :each do
      sign_in_as create :staff, :admin
    end

    it 'creates a new project record', :show_in_doc do
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

    it 'changes existing project', :show_in_doc do
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

      it 'retrieves a list of related staff', :show_in_doc do
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

      it 'adds related staff', :show_in_doc do
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

      it 'removes related staff', :show_in_doc do
        delete "/projects/#{@project.id}/staff/#{@staff.id}"
        expect(response.status).to eq(204)
      end
    end
  end
end
