class OrganizationsController < ApplicationController
  extend Apipie::DSL::Concern

  respond_to :json

  NOT_FOUND_MESSAGE = 'Not Found'.freeze
  MISSING_PARAMETER_MESSAGE = 'Missing parameter'.freeze
  RESPONSE_EXAMPLE = '{"id":1,"name":"123","description":null,"img":null,"created_at":"2014-11-17T18:33:04.202Z","updated_at":"2014-11-17T18:48:47.829Z"}'.freeze
  RESPONSE_EXAMPLE_COLLECTION = '[{"id":1,"name":"123","description":null,"img":null,"created_at":"2014-11-17T18:33:04.202Z","updated_at":"2014-11-17T18:48:47.829Z"}]'.freeze

  before_action :load_organization, only: [:show, :update, :destroy]
  before_action :load_org_params, only: [:create, :update]
  before_action :load_organizations, only: [:index]

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActionController::ParameterMissing, with: :param_missing

  api :GET, '/organizations', 'Returns a collection of organizations'
  example RESPONSE_EXAMPLE_COLLECTION

  def index
    authorize @organizations
    respond_with @organizations
  end

  api :GET, '/organizations/:id', 'Shows organization with :id'
  param :id, :number, required: true
  error code: 404, desc: NOT_FOUND_MESSAGE
  example RESPONSE_EXAMPLE

  def show
    authorize @organization
    respond_with @organization
  end

  api :POST, '/organizations', 'Creates organization'
  param :organization, Hash, desc: 'Organization' do
    param :name, String, desc: 'Name'
    param :image, String, desc: 'Image URL'
    param :description, String, desc: 'Description of organization'
  end
  error code: 422, desc: MISSING_PARAMETER_MESSAGE
  example RESPONSE_EXAMPLE

  def create
    @organization = Organization.new @org_params
    authorize @organization

    if @organization.save
      respond_with @organization
    else
      respond_with @organization.errors, status: :unprocessable_entity
    end
  end

  api :PUT, '/organizations/:id', 'Updates organization with :id'
  param :id, :number, required: true
  param :organization, Hash, desc: 'Organization' do
    param :name, String, desc: 'Name'
    param :image, String, desc: 'Image URL'
    param :description, String, desc: 'Description of organization'
  end
  error code: 404, desc: NOT_FOUND_MESSAGE
  error code: 422, desc: MISSING_PARAMETER_MESSAGE
  example RESPONSE_EXAMPLE

  def update
    authorize @organization
    @organization.update_attributes(@org_params)

    if @organization.save
      render json: @organization
    else
      respond_with @organization.errors, status: :unprocessable_entity
    end
  end

  api :DELETE, '/organizations/:id', 'Deletes organization with :id'
  param :id, :number, required: true
  error code: 404, desc: NOT_FOUND_MESSAGE
  example RESPONSE_EXAMPLE

  def destroy
    authorize @organization
    if @organization.destroy
      render json: @organization
    else
      respond_with @organization.errors, status: :unprocessable_entity
    end
  end

  private

  def load_org_params
    @org_params = params.require(:organization).permit(:name, :description, :image)
  end

  def load_organization
    @organization = Organization.find(params.require(:id))
  end

  def load_organizations
    @organizations = Organization.all
  end

  def param_missing(e)
    render json: { error: e.message }, status: 422
  end

  def record_not_found
    render json: { error: NOT_FOUND_MESSAGE }, status: 404
  end
end
