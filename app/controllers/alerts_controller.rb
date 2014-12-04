class AlertsController < ApplicationController
  respond_to :json, :xml

  after_action :verify_authorized

  before_action :load_all_alerts, only: [:show_all]
  before_action :load_active_alerts, only: [:index, :show_active]
  before_action :load_inactive_alerts, only: [:show_inactive]
  before_action :load_alert, only: [:show, :edit, :update, :destroy]
  before_action :load_update_params, only: [:update]
  before_action :load_create_params, only: [:create]
  before_action :load_alert_id, only: [:create]

  api :GET, '/alerts', 'Returns all active alerts. (Default behavior)'

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

  api :GET, '/alerts/all', 'Shows all alerts, both active and inactive.'

  def show_all
    authorize Alert.new
    respond_with @alerts
  end

  api :GET, '/alerts/active', 'Shows all active alerts. Where end_date is null or has yet to occur and start is null or has already occurred.'

  def show_active
    authorize Alert.new
    respond_with @alerts
  end

  api :GET, '/alerts/inactive', 'Shows all inactive alerts. Where end_date has already occurred or start_date has yet to occur.'

  def show_inactive
    authorize Alert.new
    respond_with @alerts
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
    if @alert_id.nil?
      if @alert.save
        respond_with @alert
      else
        respond_with @alert.errors, status: :unprocessable_entity
      end
    else # ON DUPLICATE ALERT UPDATE
      params[:id] = @alert_id
      load_alert
      load_update_params
      update
    end
  end

  api :PUT, '/alerts/:id', 'Updates value for alert with :id'
  param :project_id, String, required: true, desc: 'The project id this notification is assigned to. <br>0 indicates system wide notification.'
  param :staff_id, String, required: true, desc: 'The staff id this notification is assigned to. <br>0 indicates system generated notification.'
  param :status, String, required: true, desc: 'Status message associated issued with this notification. <br>Current Options: OK, WARNING, CRITICAL, UNKNOWN, PENDING'
  param :message, String, required: true, desc: 'Actual message content of notification.'
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
    @update_params = params.permit(:status, :message, :start_date, :end_date)
  end

  def load_all_alerts
    @alerts = Alert.all.order('id ASC')
  end

  def load_active_alerts
    @alerts = Alert.where('(start_date IS NULL OR start_date <= ?) AND (end_date IS NULL OR end_date > ?)', Time.now, Time.now).order('id ASC')
  end

  def load_inactive_alerts
    @alerts = Alert.where('end_date < ? OR start_date > ?', Time.now, Time.now).order('id ASC')
  end

  def load_alert
    @alert = Alert.find params.require(:id)
  end

  def load_alert_id
    conditions = {}
    conditions[:status] = @create_params['status']
    conditions[:message] = @create_params['message']
    conditions[:project_id] = @create_params['project_id']
    conditions[:staff_id] = @create_params['staff_id']
    @alert_id = Alert.where(conditions).first
  end
end
