class UserSettingOptionsController < ApplicationController
  after_action :verify_authorized

  before_action :load_user_setting_options, only: [:index]
  before_action :load_user_setting_option, only: [:show, :edit, :update, :destroy]
  before_action :load_update_params, only: [:update]
  before_action :load_create_params, only: [:create]
  before_action :load_id_for_user_setting_option_label, only: [:create]

  api :GET, '/user_setting_options', 'Returns a set of default staff options.'
  param :page, :number, required: false
  param :per_page, :number, required: false

  def index
    authorize UserSettingOption.new
    respond_with @user_setting_options
  end

  api :GET, '/user_setting_options/:id', 'Shows user setting option with :id'
  param :id, :number, required: true
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def show
    authorize @user_setting_option
    respond_with @user_setting_option
  end

  api :POST, '/user_setting_options', 'Create new setting that all users will have.'
  param :label, String, required: true, desc: 'The label of the setting. Varchar(255)'
  param :field_type, String, required: true, desc: 'The field type (text, textarea, radio, checkbox). Varchar(100)'
  param :help_text, String, required: true, desc: 'Inline help text to display. Varchar(255)'
  param :options, String, required: true, desc: 'JSON for options for field_type that needs them (like radio, checkbox, etc). Text BLOB.'
  param :required, String, required: true, desc: 'Whether option is mandatory. Boolean'

  def create
    @user_setting_option = UserSettingOption.new @create_params
    authorize @user_setting_option
    if @id_for_user_setting_option_label.nil?
      if @user_setting_option.save
        respond_with @user_setting_option
      else
        respond_with @user_setting_option.errors, status: :unprocessable_entity
      end
    else # ON DUPLICATE KEY UPDATE
      params[:id] = @id_for_user_setting_option_label
      load_user_setting_option
      load_update_params
      update
    end
  end

  api :PUT, '/user_setting_options/:id', 'Updates user setting option with :id'
  param :id, :number, required: true
  param :field_type, String, required: false, desc: 'The field type (text, textarea, radio, checkbox). Varchar(100)'
  param :help_text, String, required: false, desc: 'Inline help text to display. Varchar(255)'
  param :options, String, required: false, desc: 'JSON for options for field_type that needs them (like radio, checkbox, etc). Text BLOB.'
  param :required, String, required: false, desc: 'Whether option is mandatory. Boolean'
  error code: 404, desc: MissingRecordDetection::Messages.not_found
  error code: 422, desc: ParameterValidation::Messages.missing

  def update
    authorize @user_setting_option
    if @user_setting_option.update_attributes @update_params
      respond_with @user_setting_option
    else
      respond_with @user_setting_option.errors, status: :unprocessable_entity
    end
  end

  api :GET, '/user_setting_options/new', 'Get new setting JSON'

  def new
    @user_setting_option = UserSettingOption.new
    authorize @user_setting_option
    respond_with @user_setting_option
  end

  api :GET, '/user_setting_options/:id/edit', 'Get edit JSON for user setting option with :id'
  param :id, :number, required: true
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def edit
    authorize @user_setting_option
    respond_with @user_setting_option
  end

  api :DELETE, '/user_setting_options/:id', 'Deletes user setting option with :id'
  param :id, :number, required: true
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def destroy
    authorize @user_setting_option
    if @user_setting_option.destroy
      respond_with @user_setting_option
    else
      respond_with @user_setting_option.errors, status: :unprocessable_entity
    end
  end

  private

  def load_create_params
    params.require(:label)
    params.require(:field_type)
    params.require(:help_text)
    params.require(:options)
    params.require(:required)
    @create_params = params.permit(:label, :field_type, :help_text, :options, :required)
  end

  def load_update_params
    @update_params = params.permit(:field_type, :help_text, :options, :required)
  end

  def load_user_setting_options
    @user_setting_options = query_with UserSettingOption.all.order('id ASC'), :includes, :pagination
  end

  def load_user_setting_option
    @user_setting_option = UserSettingOption.find params.require(:id)
  end

  def load_id_for_user_setting_option_label
    user_setting_option_label = UserSettingOption.where(label: @create_params['label']).first
    @id_for_user_setting_option_label = (user_setting_option_label.nil? || user_setting_option_label.id.nil?) ? nil : user_setting_option_label.id
  end
end
