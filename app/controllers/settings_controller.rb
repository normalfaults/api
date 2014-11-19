class SettingsController < ApplicationController
  # extend Apipie::DSL::Concern
  include MissingRecordDetection
  include ParameterValidation

  respond_to :json, :xml

  # after_action :verify_authorized

  before_action :load_settings, only: [:index]
  before_action :load_setting, only: [:show, :edit, :update, :destroy]
  before_action :load_update_params, only: [:update]
  before_action :load_create_params, only: [:create]

  api :GET, '/settings', 'Returns a collection of settings'

  def index
    respond_with @settings
  end

  api :GET, '/settings/:id', 'Shows setting with :id'
  param :id, :number, required: true
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def show
    respond_with @setting
  end

  api :POST, '/settings', 'Create new setting'
  param :setting, Hash, required: true, desc: 'Setting' do
    param :name, String, required: true
    param :value, String, required: true
  end
  error code: 422, desc: MissingRecordDetection::Messages.not_found

  def create
    @setting = Setting.new @create_params
    if @setting.save
      respond_with @setting
    else
      respond_with @setting.errors, status: :unprocessable_entity
    end
  end

  api :PUT, '/settings/:id', 'Updates value for setting with :id'
  param :id, :number, required: true
  param :setting, Hash, required: true, desc: 'Setting' do
    param :value, String, required: true
  end
  error code: 404, desc: MissingRecordDetection::Messages.not_found
  error code: 422, desc: ParameterValidation::Messages.missing

  def update
    if @setting.update_attributes @update_params
      respond_with @setting
    else
      respond_with @setting.errors, status: :unprocessable_entity
    end
  end

  api :GET, '/settings/new', 'Get new setting JSON'

  def new
    @setting = Setting.new
    render json: @setting
  end

  api :GET, '/settings/:id/edit', 'Get edit JSON for setting with :id'
  param :id, :number, required: true
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def edit
    respond_with @setting
  end

  api :DELETE, '/settings/:id', 'Deletes setting with :id'
  param :id, :number, required: true
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def destroy
    if @setting.destroy
      respond_with @setting
    else
      respond_with @setting.errors, status: :unprocessable_entity
    end
  end

  private

  def load_create_params
    @create_params = params.require(:setting).permit(:name, :value)
  end

  def load_update_params
    @update_params = params.require(:setting).permit(:value)
  end

  def load_settings
    @settings = Setting.all.order('id ASC')
  end

  def load_setting
    @setting = Setting.find params.require(:id)
  end
end
