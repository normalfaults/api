require 'rails_helper'

RSpec.describe 'Approvals API' do
  describe 'GET index' do
    before(:each) do
      @approval = create :approval
      @approval2 = create :approval
      @approvals = Approval.all
      sign_in_as create :staff, :admin
    end

    it 'returns a collection of all of the approvals', :show_in_doc do
      get '/approvals'
      expect(json.length).to eq(2)
    end

    it 'returns a collection of all of the approvals /w staff members', :show_in_doc do
      staff = create :staff
      @approval.update_attributes(staff_id: staff.id)
      @approval2.update_attributes(staff_id: staff.id)

      get '/approvals', include: ['staff']
      expect(json[0]['staff']).to_not eq(nil)
    end

    it 'returns a collection of all of the approvals /w staff projects', :show_in_doc do
      project = create :project
      @approval.update_attributes(project_id: project.id)
      @approval2.update_attributes(project_id: project.id)

      get '/approvals', include: ['project']

      expect(json[0]['project']).to_not eq(nil)
    end
  end

  describe 'GET show' do
    before(:each) do
      @approval = create :approval
      sign_in_as create :staff, :admin
    end

    it 'returns an approval', :show_in_doc do
      get "/approvals/#{@approval.id}"
      expect(json['id']).to eq(@approval.id)
    end

    it 'returns an approval w/ a staff member', :show_in_doc do
      staff = create :staff
      @approval.update_attributes(staff_id: staff.id)

      get "/approvals/#{@approval.id}", include: ['staff']
      expect(json['staff']).to_not eq(nil)
    end

    it 'returns an approval w/ a project', :show_in_doc do
      project = create :project
      @approval.update_attributes(project_id: project.id)

      get "/approvals/#{@approval.id}", include: ['project']
      expect(json['project']).to_not eq(nil)
    end

    it 'returns an error when the approval does not exist' do
      get "/approvals/#{@approval.id + 999}"
      expect(response.status).to eq(404)
      expect(json).to eq('error' => 'Not found.')
    end
  end

  describe 'PUT update' do
    before(:each) do
      create :approval, :unapproved
      @approval = Approval.first
      sign_in_as create :staff, :admin
    end

    it 'updates a approval', :show_in_doc do
      put "/approvals/#{@approval.id}", approval: { approved: true }
      expect(response.status).to eq(204)
    end

    it 'returns an error if the approval parameter is missing' do
      put "/approvals/#{@approval.id}"
      expect(response.status).to eq(422)
      expect(json).to eq('error' => 'param is missing or the value is empty: approval')
    end

    it 'returns an error when the approval does not exist' do
      put "/approvals/#{@approval.id + 999}", approval: { approved: true  }
      expect(response.status).to eq(404)
      expect(json).to eq('error' => 'Not found.')
    end
  end

  describe 'POST create' do
    before :each do
      @approval = build :approval
      sign_in_as create :staff, :admin
    end

    it 'creates an approval', :show_in_doc do
      post '/approvals/', approval: @approval.as_json
      expect(response.body).to eq(Approval.first.to_json)
    end

    it 'returns an error if the approval is missing' do
      post '/approvals/'
      expect(response.status).to eq(422)
      expect(json).to eq('error' => 'param is missing or the value is empty: approval')
    end
  end

  describe 'DELETE destroy' do
    before :each do
      @approval = create :approval
      sign_in_as create :staff, :admin
    end

    it 'removes the product', :show_in_doc do
      delete "/approvals/#{@approval.id}"
      expect(response.status).to eq(204)
    end

    it 'returns an error when the product does not exist' do
      delete "/approvals/#{@approval.id + 999}"
      expect(response.status).to eq(404)
      expect(json).to eq('error' => 'Not found.')
    end
  end
end
