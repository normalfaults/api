class SettingsController < ApplicationController
  before_action :load_settings, only: [:index]
  before_action :load_setting, only: [:update, :destroy, :edit]
  before_action :load_setting_by_name, only: [:show]

  api :GET, '/settings', 'Returns a collection of admin settings'
  param :includes, Array, required: false, in: %w(setting_fields)
  param :page, :number, required: false
  param :per_page, :number, required: false

  def index
    respond_with_params @settings
  end

  api :GET, '/settings/new', 'Get new setting JSON'

  def new
    @setting = Setting.new
    authorize @setting
    render json: @setting
  end

  api :GET, '/settings/:id/edit', 'Get edit JSON for setting with :id'
  param :id, :number, required: true
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def edit
    authorize @setting
    respond_with @setting
  end

  api :GET, '/settings/:name', 'Returns the settings with the matching name'
  param :includes, Array, required: false, in: %w(setting_fields)

  def show
    if @setting
      respond_with_params @setting
    else
      record_not_found
    end
  end

  api :DELETE, '/settings/:id', 'Deletes setting with :id'
  param :id, :number, required: true
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def destroy
    authorize @setting
    @setting.destroy
    respond_with @setting
  end

  api :PUT, '/settings/:id', 'Updates value for setting with :id'
  param :id, :number, required: true
  param :admin_settings_fields, Array, required: false, desc: 'Setting field' do
    param :id, :number, required: true
    param :value, String, required: true
  end
  error code: 404, desc: MissingRecordDetection::Messages.not_found
  error code: 422, desc: ParameterValidation::Messages.missing

  def update
    @setting.update @setting_params
    respond_with @setting
  end

  protected

  def load_setting
    @setting_params = params.permit(setting_fields: [:id, :value])
    @setting_params[:setting_fields_attributes] = @setting_params[:setting_fields] unless @setting_params[:setting_fields].nil?
    @setting_params.delete(:setting_fields) unless @setting_params[:setting_fields].nil?
    @setting = Setting.find(params.require(:id))
  end

  def load_setting_by_name
    @setting = Setting.find_by(name: params.require(:id))
  end

  def load_settings
    @settings = query_with Setting.all, :includes, :pagination
  end
end
