class AlertsController < ApplicationController
  respond_to :json, :xml

  after_action :verify_authorized

  before_action :load_alerts, only: [:index]
  before_action :load_alert, only: [:show, :edit, :update, :destroy]
  before_action :load_update_params, only: [:update]
  before_action :load_create_params, only: [:create]

  api :GET, '/alerts', 'Returns a collection of all alerts'

  def index
    authorize Alert.new
    respond_with @alerts
  end

  api :GET, '/alerts/:id', 'Shows alert with :id'
  param :id, :number, required: true
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def show
    authorize @alert
    respond_with @alert
  end

  api :POST, '/alerts', 'Create new setting'
  param :project_id, String, required: true, desc: 'The project id this notification is assigned to. <br>0 indicates system wide notification.'
  param :staff_id, String, required: true, desc: 'The staff id this notification is assigned to. <br>0 indicates system generated notification.'
  param :status, String, required: true, desc: 'Status message associated issued with this notification. <br>Current Options: OK, WARNING, CRITICAL, UNKNOWN, PENDING'
  param :message, String, required: true, desc: 'Actual message content of notification.'
  param :start_date, String, required: false, desc: 'Date this notification will start appearing. Null indicates a notification will start appearing immediately.'
  param :end_date, String, required: false, desc: 'Date this notification should no longer be displayed. Null indicates a notification will persist after appearing until removed.'
  error code: 422, desc: MissingRecordDetection::Messages.not_found

  def create
    @alert = Alert.new @create_params
    authorize @alert
    if @alert.save # TODO: ADD LOGIC TO HANDLE REDUNDANT ALERTS
      respond_with @alert
    else
      respond_with @alert.errors, status: :unprocessable_entity
    end
  end

  api :PUT, '/alerts/:id', 'Updates value for alert with :id'
  param :project_id, String, required: false, desc: 'The project id this notification is assigned to. <br>0 indicates system wide notification.'
  param :staff_id, String, required: false, desc: 'The staff id this notification is assigned to. <br>0 indicates system generated notification.'
  param :status, String, required: false, desc: 'Status message associated issued with this notification. <br>Current Options: OK, WARNING, CRITICAL, UNKNOWN, PENDING'
  param :message, String, required: false, desc: 'Actual message content of notification.'
  param :start_date, String, required: false, desc: 'Date this notification will start appearing. Null indicates a notification will start appearing immediately.'
  param :end_date, String, required: false, desc: 'Date this notification should no longer be displayed. Null indicates a notification will persist after appearing until removed.'
  error code: 404, desc: MissingRecordDetection::Messages.not_found
  error code: 422, desc: ParameterValidation::Messages.missing

  def update
    authorize @alert
    if @alert.update_attributes @update_params
      respond_with @alert
    else
      respond_with @alert.errors, status: :unprocessable_entity
    end
  end

  # api :GET, '/settings/new', 'Get new setting JSON'
  #
  # def new
  #   @setting = Setting.new
  #   authorize @setting
  #   render json: @setting
  # end
  #
  # api :GET, '/settings/:id/edit', 'Get edit JSON for setting with :id'
  # param :id, :number, required: true
  # error code: 404, desc: MissingRecordDetection::Messages.not_found
  #
  # def edit
  #   authorize @setting
  #   respond_with @setting
  # end

  api :DELETE, '/alerts/:id', 'Deletes alert with :id'
  param :id, :number, required: true
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def destroy
    authorize @alert
    if @alert.destroy
      respond_with @alert
    else
      respond_with @alert.errors, status: :unprocessable_entity
    end
  end

  private

  def load_create_params
    params.require :project_id
    params.require :staff_id
    params.require :status
    params.require :message
    @create_params = params.permit(:project_id, :staff_id, :status, :message, :start_date, :end_date)
  end

  def load_update_params
    @update_params = params.permit(:project_id, :staff_id, :status, :message, :start_date, :end_date)
  end

  def load_alerts
    @alerts = Alert.all.order('id ASC')
  end

  def load_alert
    @alert = Alert.find params.require(:id)
  end
end
