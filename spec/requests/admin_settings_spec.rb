require 'rails_helper'

RSpec.describe 'Admin Setting API' do
  let(:default_params) { { format: :json } }

  describe 'GET index' do
    before(:each) do
      admin_setting = create :admin_setting
      admin_setting.admin_setting_fields << create(:admin_setting_field)
      sign_in_as create :staff, :admin
      @admin_settings = AdminSetting.all
    end

    it 'returns a collection of all of the admin_settings' do
      get '/admin_settings'
      expect(response.body).to eq(@admin_settings.to_json(include: %w(admin_setting_fields)))
    end
  end

  describe 'GET show' do
    before(:each) do
      @admin_setting = create :admin_setting, name: 'test'
      sign_in_as create :staff, :admin
    end

    it 'returns an admin settings', :show_in_doc do
      get "/admin_settings/#{@admin_setting.name}"
      expect(response.body).to eq(@admin_setting.to_json(include: %w(admin_setting_fields)))
    end

    it 'returns an error when the admin setting does not exist' do
      get '/admin_settings/BadName'
      expect(response.status).to eq(404)
      expect(json).to eq('error' => 'Not found.')
    end
  end

  describe 'PUT update' do
    before(:each) do
      @admin_setting = create :admin_setting
      @admin_setting.admin_setting_fields.create(value: 'old')
      sign_in_as create :staff, :admin
    end

    it 'updates a admin setting', :show_in_doc do
      put "/admin_settings/#{@admin_setting.id}", admin_setting_fields: [{ id: @admin_setting.admin_setting_fields.first.id, value: 'new' }]
      expect(AdminSettingField.first.value).to eq('new')
    end

    it 'returns an error when the cloud does not exist' do
      put "/admin_settings/#{@admin_setting.id + 999}"
      expect(response.status).to eq(404)
      expect(json).to eq('error' => 'Not found.')
    end
  end
end
