require 'rails_helper'

context 'Staff Projects API' do
  describe :index do
    it 'retrieves a list of related projects', :show_in_doc do
      project = create :project
      staff = create :staff, :user
      staff.projects << project
      sign_in_as create :staff, :admin

      get "/staff/#{staff.id}/projects"
      expect(response.status).to eq(200)
      expect(json.length).to eq(1)
    end
  end

  describe :update do
    it 'adds related project', :show_in_doc do
      project = create :project
      staff = create :staff, :user
      sign_in_as create :staff, :admin

      put "/staff/#{staff.id}/projects/#{project.id}"
      staff.reload
      expect(response.status).to eq(204)
      expect(staff.projects.length).to eq(1)
    end
  end

  describe :destroy do
    it 'removes related project', :show_in_doc do
      project = create :project
      staff = create :staff, :user
      staff.projects << project
      sign_in_as create :staff, :admin

      delete "/staff/#{staff.id}/projects/#{project.id}"
      staff.reload
      expect(response.status).to eq(204)
      expect(staff.projects.length).to eq(0)
    end
  end
end
