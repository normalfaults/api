require 'rails_helper'

context 'Staff Settings API' do
  describe :index do
    it 'retrieves a list of user settings', :show_in_doc do
      staff = create :staff, :user
      user_setting = create :user_setting
      staff.user_settings << user_setting
      sign_in_as create :staff, :admin

      get "/staff/#{staff.id}/settings"
      expect(response.status).to eq(200)
    end
  end

  describe :show do
    it 'looks up a user setting from id', :show_in_doc do
      staff = create :staff, :user
      user_setting = create :user_setting
      staff.user_settings << user_setting
      sign_in_as create :staff, :admin

      get "/staff/#{staff.id}/settings/#{user_setting.id}"
      expect(response.status).to eq(200)
      expect(json['name']).to eq(user_setting.name)
    end
  end

  describe :create do
    it 'adds user setting to staff', :show_in_doc do
      staff = create :staff, :user
      sign_in_as staff

      data = attributes_for :user_setting
      post "/staff/#{staff.id}/settings", data
      expect(json['name']).to eq(data[:name])
      expect(json['staff_id']).to eq(staff.id)
    end
  end

  describe :update do
    it 'changes user setting of staff', :show_in_doc do
      staff = create :staff, :user
      user_setting = create :user_setting
      staff.user_settings << user_setting
      sign_in_as staff

      data = { value: 'updated' }
      put "/staff/#{staff.id}/settings/#{user_setting.id}", data
      expect(response.status).to eq(204)
    end
  end

  describe :destroy do
    it 'removes user setting from staff', :show_in_doc do
      staff = create :staff, :user
      user_setting = create :user_setting
      staff.user_settings << user_setting
      sign_in_as staff

      delete "/staff/#{staff.id}/settings/#{user_setting.id}"
      expect(response.status).to eq(204)
    end
  end
end
