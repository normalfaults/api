class SettingsController < ApplicationController
  api :GET, '/settings', 'Returns a collection of admin settings'
  param :includes, Array, required: false, in: %w(setting_fields)
  param :page, :number, required: false
  param :per_page, :number, required: false

  def index
    settings = query_with Setting.all, :includes, :pagination
    respond_with_params settings
  end

  api :GET, '/settings/:hid', 'Returns the settings with the matching hid'
  param :includes, Array, required: false, in: %w(setting_fields)

  def show
    hid_setting = Setting.find_by! hid: params.require(:id)
    respond_with_params hid_setting
  end

  api :DELETE, '/settings/:id', 'Deletes setting with :id'
  param :id, :number, required: true
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def destroy
    setting.destroy
    respond_with setting
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
    setting.update setting_params
    respond_with setting
  end

  private

  def setting
    @setting ||= Setting.find(params.require(:id)).tap { |obj| authorize obj }
  end

  def setting_params
    @setting_params ||= params.permit(:id, :name, setting_fields: [:id, :value]).tap do |settings|
      if params[:setting_fields]
        settings[:setting_fields_attributes] = settings.delete(:setting_fields)
      end
    end
  end
end
