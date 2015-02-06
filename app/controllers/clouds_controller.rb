class CloudsController < ApplicationController
  after_action :verify_authorized

  before_action :load_cloud, only: [:show, :update, :destroy]
  before_action :load_cloud_params, only: [:create, :update]
  before_action :load_clouds, only: [:index]

  api :GET, '/clouds', 'Returns a collection of clouds'
  param :includes, Array, required: false, in: %w(chargebacks  products)
  param :page, :number, required: false
  param :per_page, :number, required: false

  def index
    authorize Cloud
    respond_with_params @clouds
  end

  api :GET, '/clouds/:id', 'Shows cloud with :id'
  param :id, :number, required: true
  param :includes, Array, required: false, in: %w(chargebacks products)
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def show
    authorize @cloud
    respond_with_params @cloud
  end

  api :POST, '/clouds', 'Creates a cloud'
  param :name, String, required: false
  param :desciption, String, required: false
  param :extra, String, required: false
  error code: 422, desc: ParameterValidation::Messages.missing

  def create
    @cloud = Cloud.new @cloud_params
    authorize @cloud
    @cloud.save
    respond_with @cloud
  end

  api :PUT, '/cloud/:id', 'Updates cloud with :id'
  param :id, :number, required: true
  param :name, String, required: false
  param :desciption, String, required: false
  param :extra, String, required: false
  error code: 404, desc: MissingRecordDetection::Messages.not_found
  error code: 422, desc: ParameterValidation::Messages.missing

  def update
    @cloud.update_attributes @cloud_params
    authorize @cloud
    @cloud.save
    respond_with @cloud
  end

  api :DELETE, '/cloud/:id', 'Deletes cloud with :id'
  param :id, :number, required: true
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def destroy
    authorize @cloud
    @cloud.destroy
    respond_with @cloud
  end

  private

  def load_cloud_params
    @cloud_params = params.permit(:name, :description, :extra)
  end

  def load_cloud
    @cloud = Cloud.find(params.require(:id))
  end

  def load_clouds
    @clouds = query_with Cloud.all, :includes, :pagination
  end
end
