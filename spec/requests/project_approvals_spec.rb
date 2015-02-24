require 'rails_helper'

context 'Project Approvals API' do
  describe 'index' do
    it 'has a positive approval' do
      sign_in_as create :staff, :admin
      approved_project = create :project
      approved_project.approvals << create(:approval)

      get "projects/#{approved_project.id}/approvals.json"

      expect(json.length).to eq(1)
      expect(json[0]['approved']).to eq(true)
    end

    it 'has a rejected approval' do
      sign_in_as create :staff, :admin
      reason = 'Because reasons'
      rejected_project = create :project
      rejected_project.approvals << create(:approval, :unapproved, reason: reason)

      get "projects/#{rejected_project.id}/approvals.json"

      expect(json.length).to eq(1)
      expect(json[0]['approved']).to eq(false)
      expect(json[0]['reason']).to eq(reason)
    end
  end

  describe 'update' do
    it 'approves a project' do
      sign_in_as create :staff, :admin
      project = create :project

      post "/projects/#{project.id}/approve.json", includes: %w(approvals)

      project.reload
      expect(project.approval).to eq('approved')
      expect(json['approval']).to eq('approved')
      expect(json['approvals'].length).to eq(1)
      expect(json['approvals'][0]['approved']).to eq(true)
    end

    it 'returns an error for users' do
      sign_in_as create :staff
      project = create :project

      post "/projects/#{project.id}/approve.json"

      expect(response.status).to eq(403)
    end
  end

  describe 'destroy' do
    it 'rejects a project' do
      project = create :project
      reason = 'because'
      sign_in_as create :staff, :admin

      delete "/projects/#{project.id}/reject.json", reason: reason, includes: %w(approvals)

      expect(project.reload.approval).to eq('rejected')
      expect(response.status).to eq 204
    end

    it 'returns an error when no reason is provided' do
      project = create :project
      sign_in_as create :staff, :admin

      expect { delete "/projects/#{project.id}/reject" }
        .to raise_error(Apipie::ParamMissing)
    end

    it 'returns an error for users' do
      project = create :project
      sign_in_as create :staff

      delete "/projects/#{project.id}/reject", reason: 'because'

      expect(response.status).to eq(403)
    end
  end
end
