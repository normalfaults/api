class StaffController < ApplicationController
  respond_to :json

  skip_before_filter :authenticate_user!, except: [:current_member]

  before_action :load_staffs, only: [:index]
  before_action :load_staff, only: [:show, :update, :destroy, :projects, :add_project, :remove_project, :user_settings, :show_user_setting, :add_user_setting, :update_user_setting, :remove_user_setting]
  before_action :load_project, only: [:add_project, :remove_project]
  before_action :load_user_settings, only: [:user_settings]
  before_action :load_update_user_setting_params, only: [:update_user_setting]
  before_action :load_add_user_setting_params, only: [:add_user_setting]
  before_action :load_id_for_user_setting_name, only: [:add_user_setting]
  before_action :load_user_setting, only: [:show_user_setting, :update_user_setting, :remove_user_setting]
  before_action :load_staff_params, only: [:create, :update]

  api :GET, '/staff', 'Returns a collection of staff'
  param :query, String, required: false, desc: 'queries against first name, last name, and email'
  param :methods, Array, required: false, in: %w(gravatar allowed)
  param :includes, Array, required: false, in: %w(user_settings projects)
  def index
    authorize Staff.new
    respond_with_params @staffs
  end

  api :GET, '/staff/:id', 'Shows staff member with :id'
  param :id, :number, required: true
  param :includes, Array, required: false, in: %w(user_settings projects)
  error code: 404, desc: MissingRecordDetection::Messages.not_found
  def show
    authorize @staff
    respond_with_params @staff
  end

  api :GET, '/staff/current_member', 'Shows logged in member'
  param :includes, Array, required: false, in: %w(user_settings projects notifications cart)
  error code: 401, desc: 'User is not signed in.'
  def current_member
    @staff = current_user

    if @staff
      respond_with_params @staff
    else
      render json: { error: 'No session.' }, status: 401
    end
  end

  api :POST, '/staff', 'Creates a staff member'
  param :staff, Hash, desc: 'Staff' do
  end
  error code: 422, desc: MissingRecordDetection::Messages.not_found
  def create
    @staff = Staff.new @staff_params
    authorize @staff
    @staff.save
    respond_with @staff
  end

  api :PUT, '/staff/:id', 'Updates a staff member with :id'
  param :id, :number, required: true
  param :staff, Hash, desc: 'Staff' do
  end
  error code: 404, desc: MissingRecordDetection::Messages.not_found
  error code: 422, desc: ParameterValidation::Messages.missing
  def update
    authorize @staff
    @staff.update_attributes @staff_params
    respond_with @staff
  end

  api :DELETE, '/staff/:id', 'Deletes staff member with :id'
  param :id, :number, required: true
  error code: 404, desc: MissingRecordDetection::Messages.not_found
  def destroy
    authorize @staff
    @staff.destroy
    respond_with @staff
  end

  api :GET, '/staff/:id/project', 'Shows collection of projects for a staff :id'
  param :id, :number, required: true
  error code: 404, desc: MissingRecordDetection::Messages.not_found
  def projects
    authorize @staff
    respond_with @staff.projects
  end

  api :POST, '/staff/:id/projects/:project_id', 'Adds project to a staff member'
  param :id, :number, required: true
  param :project_id, :number, desc: 'Project'
  error code: 422, desc: MissingRecordDetection::Messages.not_found
  def add_project
    authorize @staff
    if @staff.projects << @project
      respond_with @project
    else
      respond_with @staff, status: :unprocessable_entity
    end
  end

  api :DELETE, '/staff/:id/project/:project_id', 'Deletes project from a staff'
  param :id, :number, required: true
  param :staff, Hash, desc: 'Staff' do
    param :id, :number, required: true
  end
  error code: 404, desc: MissingRecordDetection::Messages.not_found
  def remove_project
    authorize @staff
    if @staff.projects.delete @project
      respond_with @project
    else
      respond_with @staff, status: :unprocessable_entity
    end
  end

  api :GET, '/staff/:id/settings', 'Shows collection of user settings for a staff :id'
  param :id, :number, required: true, desc: 'staff_id'
  error code: 404, desc: MissingRecordDetection::Messages.not_found
  def user_settings
    authorize @staff
    respond_with @user_settings
  end

  api :GET, '/staff/:id/settings/:user_setting_id', 'Shows user settings detail'
  param :id, :number, required: true, desc: 'staff_id'
  param :user_setting_id, :number, required: true, desc: 'user_setting_id'
  error code: 404, desc: MissingRecordDetection::Messages.not_found
  def show_user_setting
    authorize @staff
    respond_with @user_setting
  end

  api :POST, '/staff/:id/settings', 'Adds user setting to a staff member. Duplicate user setting name triggers update.'
  param :id, :number, required: true, desc: 'staff_id'
  param :user_setting, Hash, required: true, desc: 'User Setting' do
    param :name, String, required: true
    param :value, String, required: true
  end
  error code: 422, desc: MissingRecordDetection::Messages.not_found
  def add_user_setting
    authorize @staff
    @user_setting = UserSetting.new @add_user_setting_params
    @user_setting[:staff_id] = params[:id]
    if @id_for_user_setting_name.nil?
      if @user_setting.save
        render json: @user_setting
      else
        respond_with @user_setting, status: :unprocessable_entity
      end
    else # ON DUPLICATE KEY UPDATE
      params[:user_setting_id] = @id_for_user_setting_name
      load_update_user_setting_params
      load_user_setting
      update_user_setting
    end
  end

  api :PUT, '/staff/:id/settings/:user_setting_id', 'Updates a staff member\'s user setting with a new value.'
  param :id, :number, required: true, desc: 'staff_id'
  param :user_setting_id, :number, required: true, desc: 'user_setting_id'
  param :user_setting, Hash, required: true, desc: 'User Setting' do
    param :value, String, required: true
  end
  error code: 422, desc: MissingRecordDetection::Messages.not_found
  def update_user_setting
    authorize @staff
    if @user_setting.update_attributes @update_user_setting_params
      render json: @user_setting
    else
      respond_with @user_setting, status: :unprocessable_entity
    end
  end

  api :DELETE, '/staff/:id/settings/:user_setting_id', 'Deletes a user setting from a staff member.'
  param :id, :number, required: true, desc: 'staff_id'
  param :user_setting_id, :number, required: true, desc: 'user_setting_id'
  error code: 422, desc: MissingRecordDetection::Messages.not_found
  def remove_user_setting
    authorize @staff
    if @user_setting.destroy
      render json: @user_setting
    else
      respond_with @user_setting, status: :unprocessable_entity
    end
  end

  private

  def load_staffs
    @staffs_params = params.permit :query, :includes

    if @staffs_params[:query]
      @staffs = Staff.search @staffs_params[:query]
    else
      @staffs = query_with_includes Staff.all
    end
  end

  def load_staff_params
    @staff_params = params.permit(:first_name, :last_name, :email, :role, :password, :password_confirmation)
  end

  def load_staff
    @staff = Staff.find params.require(:id)
  end

  def load_project
    @project = Project.find params.require(:project_id)
  end

  def load_user_setting
    @user_setting = UserSetting.find params.require(:user_setting_id)
  end

  def load_user_settings
    @user_settings = UserSetting.where('staff_id = ?', params[:id])
  end

  def load_add_user_setting_params
    @add_user_setting_params = params.require(:user_setting).permit(:name, :value)
  end

  def load_update_user_setting_params
    @update_user_setting_params = params.require(:user_setting).permit(:value)
  end

  def load_id_for_user_setting_name
    user_setting = UserSetting.where('staff_id = ? AND name = ?', params[:id], @add_user_setting_params['name']).first
    @id_for_user_setting_name = (user_setting.nil? || user_setting.id.nil?) ? nil : user_setting.id
  end
end
