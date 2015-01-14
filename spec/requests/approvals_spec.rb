require 'rails_helper'

RSpec.describe 'Approvals API' do
  let(:default_params) { { format: :json } }

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

      get '/approvals', includes: ['staff']
      expect(json[0]['staff']).to_not eq(nil)
    end

    it 'paginates the approvals' do
      get '/approvals', page: 1, per_page: 1
      expect(json.length).to eq(1)
    end

    it 'returns a collection of all of the approvals /w staff projects', :show_in_doc do
      project = create :project
      @approval.update_attributes(project_id: project.id)
      @approval2.update_attributes(project_id: project.id)

      get '/approvals', includes: ['project']

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

      get "/approvals/#{@approval.id}", includes: ['staff']
      expect(json['staff']).to_not eq(nil)
    end

    it 'returns an approval w/ a project', :show_in_doc do
      project = create :project
      @approval.update_attributes(project_id: project.id)

      get "/approvals/#{@approval.id}", includes: ['project']
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
