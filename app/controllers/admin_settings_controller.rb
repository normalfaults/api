class AdminSettingsController < ApplicationController
  respond_to :json

  before_action :load_admin_settings, only: [:index]
  before_action :load_admin_setting, only: [:update]
  before_action :load_admin_setting_by_name, only: [:show]

  api :GET, '/admin_settings/:name', 'Returns the settings with the matching name'
  param :includes, Array, required: false, in: %w(admin_setting_fields)

  def show
    if @admin_setting
      respond_with_params @admin_setting
    else
      record_not_found
    end
  end

  api :GET, '/admin_settings', 'Returns a collection of admin settings'
  param :includes, Array, required: false, in: %w(admin_setting_fields)

  def index
    respond_with_params @admin_settings
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
    @admin_setting.update_field_values_with_params!(@admin_setting_params[:admin_setting_fields])
    respond_with @admin_setting
  end

  protected

  def load_admin_setting
    @admin_setting_params = params.permit(admin_setting_fields: [:id, :value])
    @admin_setting = AdminSetting.find(params.require(:id))
  end

  def load_admin_setting_by_name
    @admin_setting = AdminSetting.find_by(name: params.require(:id))
  end

  def load_admin_settings
    @admin_settings = query_with_includes AdminSetting.all
  end
end
