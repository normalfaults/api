class StaffSettingsController < ApplicationController
  api :GET, '/staff/:staff_id/settings', 'Shows collection of user settings for a staff :id'
  param :staff_id, :number, required: true, desc: 'staff_id'
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def index
    authorize staff, :user_settings?
    respond_with user_settings
  end

  api :GET, '/staff/:staff_id/settings/:id', 'Shows user settings detail'
  param :staff_id, :number, required: true, desc: 'staff_id'
  param :id, :number, required: true, desc: 'user_setting_id'
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def show
    authorize staff, :show_user_setting?
    respond_with user_setting
  end

  api :POST, '/staff/:staff_id/settings', 'Adds user setting to a staff member. Duplicate user setting name triggers update.'
  param :staff_id, :number, required: true, desc: 'staff_id'
  param :name, String, required: true
  param :value, String, required: true
  error code: 422, desc: MissingRecordDetection::Messages.not_found

  def create
    authorize staff, :create_user_setting?
    user_setting = staff.user_settings.create! user_setting_params
    respond_with user_setting, location: staff_settings_url(staff, user_setting)
  end

  api :PUT, '/staff/:staff_id/settings/:id', 'Updates a staff member\'s user setting with a new value.'
  param :staff_id, :number, required: true, desc: 'staff_id'
  param :id, :number, required: true, desc: 'user_setting_id'
  param :value, String, required: true
  error code: 422, desc: MissingRecordDetection::Messages.not_found

  def update
    authorize staff, :update_user_setting?
    user_setting.update_attributes user_setting_params
    respond_with user_setting
  end

  api :DELETE, '/staff/:id/settings/:id', 'Deletes a user setting from a staff member.'
  param :staff_id, :number, required: true, desc: 'staff_id'
  param :id, :number, required: true, desc: 'user_setting_id'
  error code: 422, desc: MissingRecordDetection::Messages.not_found

  def destroy
    authorize staff, :destroy_user_setting?
    user_setting.destroy
    respond_with user_setting
  end

  private

  def staff
    @staff ||= Staff.find params.require :staff_id
  end

  def user_setting
    @user_setting ||= UserSetting.find params.require :id
  end

  def user_settings
    staff.user_settings
  end

  def user_setting_params
    @user_setting_params ||= params.permit(:name, :value)
  end
end
