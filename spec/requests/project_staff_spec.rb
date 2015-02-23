require 'rails_helper'

RSpec.describe 'Project Staff API', :show_in_doc do
  describe 'index' do
    it 'retrieves a list of related staff' do
      staff = create :staff, :user
      project = create :project
      project.staff << staff
      sign_in_as create :staff, :admin

      get "/projects/#{project.id}/staff.json"

      expect(response.status).to eq(200)
      expect(json.length).to eq(1)
    end
  end

  describe 'create' do
    it 'adds related staff' do
      staff = create :staff, :user
      project = create :project
      sign_in_as create :staff, :admin

      post("/projects/#{project.id}/staff/#{staff.id}.json")

      expect(response.status).to eq(201)
      expect(json['first_name']).to eq(staff.first_name)
    end
  end

  describe 'destroy' do
    it 'removes related staff' do
      staff = create :staff, :user
      project = create :project
      project.staff << staff
      sign_in_as create :staff, :admin

      delete "/projects/#{project.id}/staff/#{staff.id}.json"

      expect(response.status).to eq(204)
    end
  end
end
