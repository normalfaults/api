require 'rails_helper'

RSpec.describe 'User Setting Options API' do
  describe 'GET index' do
    before :each do
      sign_in_as create :staff, :admin
    end

    it 'returns a collection of all user setting options', :show_in_doc do
      create :user_setting_option, :first
      create :user_setting_option, :second
      create :user_setting_option, :third
      get user_setting_options_path
      expect(json.length).to eq(3)
    end
  end

  describe 'GET show' do
    before :each  do
      @user_setting_option = create :user_setting_option
      sign_in_as create :staff, :admin
    end

    it 'retrieves user setting option by id', :show_in_doc do
      get user_setting_option_path @user_setting_option.id
      expect(json['label']).to eq(@user_setting_option.label)
    end

    it 'returns an error when the user setting option does not exist' do
      get user_setting_option_path @user_setting_option.id + 999
      expect(response.status).to eq(404)
      expect(json).to eq('error' => 'Not found.')
    end
  end

  describe 'POST create' do
    before :each do
      sign_in_as create :staff, :admin
    end

    it 'creates a new user setting option', :show_in_doc do
      user_setting_option_data = { label: 'foo', field_type: 'bar', help_text: 'fizz', options: 'buzz', required: true }
      post user_setting_options_path user_setting_option_data
      expect(json['name']).to eq(user_setting_option_data[:name])
    end

    it 'returns an error if the user setting option data is missing' do
      post user_setting_options_path
      expect(response.status).to eq(422)
      expect(json).to eq('error' => 'param is missing or the value is empty: label')
    end
  end

  describe 'PUT update' do
    before :each do
      @user_setting_option = create :user_setting_option
      sign_in_as create :staff, :admin
    end

    it 'changes existing user setting option value', :show_in_doc do
      put user_setting_option_path @user_setting_option.id, field_type: 'Updated'
      expect(response.status).to eq(204)
    end

    it 'returns an error when the user setting option does not exist' do
      put user_setting_option_path @user_setting_option.id + 999, field_type: 'Updated'
      expect(response.status).to eq(404)
      expect(json).to eq('error' => 'Not found.')
    end
  end

  describe 'DELETE destroy' do
    before :each do
      @user_setting_option = create :user_setting_option
      sign_in_as create :staff, :admin
    end

    it 'verifies a setting no longer exists after delete', :show_in_doc do
      delete user_setting_option_path @user_setting_option.id
      expect(response.status).to eq(204)
    end
  end
end
