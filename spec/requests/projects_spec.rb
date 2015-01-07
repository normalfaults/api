require 'rails_helper'

RSpec.describe 'Projects API' do
  let(:default_params) { { format: :json } }

  let(:question) { 'Why did the chicken cross the road?' }
  let(:answer) { 'To get to the other side.' }
  let(:project_name) { 'To get to the other side.' }
  let(:question_model) { create :project_question, question: question, load_order: 0 }

  describe 'GET index' do
    before :each do
      sign_in_as create :staff, :admin
    end

    it 'returns a collection of all projects', :show_in_doc  do
      project = create :project
      project2 = create :project
      create :project_detail, project_id: project.id
      create :project_detail, project_id: project2.id
      staff = create :staff
      create :staff_project, staff_id: staff.id, project_id: project.id
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
      post '/projects', project_data
      expect(json['name']).to eq(project_data[:name])
    end

    it 'creates a new project record w/ project answers', :show_in_doc do
      project_data = { name: 'Created', description: 'description', cc: 'cc', staff_id: 'staff_id', budget: 1, start_date: DateTime.now.to_date, end_date: DateTime.now.to_date + 1.week, approved: 'Y', img: 'img', project_answers: [{ project_question_id: question_model.id, answer: answer }] }
      post '/projects', project_data.merge(includes: %w(project_answers))

      expect(json['project_answers'][0]['id']).to eq(ProjectAnswer.first.id)
    end
  end

  describe 'PUT update' do
    before :each do
      @project = create :project
      sign_in_as create :staff, :admin
    end

    it 'changes existing project' do
      put "/projects/#{@project.id}", name: 'Updated', budget: 1.99
      expect(response.status).to eq(200)
    end

    it 'updates a project record w/ project answers', :show_in_doc do
      project_data = { name: 'Created', description: 'description', cc: 'cc', staff_id: 'staff_id', budget: 1, start_date: DateTime.now.to_date, end_date: DateTime.now.to_date + 1.week, approved: 'Y', img: 'img', project_answers: [{ project_question_id: question_model.id, answer: answer }] }
      put "/projects/#{@project.id}", project_data.merge(includes: %w(project_answers))

      expect(json['project_answers'][0]['id']).to eq(ProjectAnswer.first.id)
    end

    it 'returns an error when the project does not exist' do
      put "/projects/#{@project.id + 999}", name: 'Updated'
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

  context 'Approvals' do
    describe 'PUT approve' do
      before :each do
        @staff = create :staff, :user
        @project = create :project
        @extra_project = create :project
        @approval = build :approval
        @approval.staff = @staff
        @project.approvals << @approval
        sign_in_as @staff
      end

      it 'approves an approval' do
        put "/projects/#{@project.id}/approve"
        @approval.reload
        expect(@approval.approved).to eq(true)
      end

      it 'non-approvers cannot approve' do
        put "/projects/#{@extra_project.id}/approve"
        expect(response.status).to eq(403)
      end
    end

    describe 'PUT reject' do
      before :each do
        @staff = create :staff, :user
        @project = create :project
        @extra_project = create :project
        @approval = build :approval
        @approval.staff = @staff
        @project.approvals << @approval
        sign_in_as @staff
      end

      it 'rejects an approval' do
        put "/projects/#{@project.id}/reject"
        @approval.reload
        expect(@approval.approved).to eq(false)
      end

      it 'non-approvers cannot reject' do
        put "/projects/#{@extra_project.id}/reject"
        expect(response.status).to eq(403)
      end
    end
  end
end
