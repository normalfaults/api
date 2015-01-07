class OrganizationsController < ApplicationController
  respond_to :json

  before_action :load_organization, only: [:show, :update, :destroy]
  before_action :load_org_params, only: [:create, :update]
  before_action :load_organizations, only: [:index]

  api :GET, '/organizations', 'Returns a collection of organizations'

  def index
    authorize @organizations
    respond_with_params @organizations
  end

  api :GET, '/organizations/:id', 'Shows organization with :id'
  param :id, :number, required: true
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def show
    authorize @organization
    respond_with_params @organization
  end

  api :POST, '/organizations', 'Creates organization'
  param :name, String, desc: 'Name'
  param :image, String, desc: 'Image URL'
  param :description, String, desc: 'Description of organization'
  error code: 422, desc: MissingRecordDetection::Messages.not_found

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
  param :name, String, desc: 'Name'
  param :image, String, desc: 'Image URL'
  param :description, String, desc: 'Description of organization'
  error code: 404, desc: MissingRecordDetection::Messages.not_found
  error code: 422, desc: ParameterValidation::Messages.missing

  def update
    authorize @organization

    if @organization.update_attributes(@org_params)
      render json: @organization
    else
      respond_with @organization.errors, status: :unprocessable_entity
    end
  end

  api :DELETE, '/organizations/:id', 'Deletes organization with :id'
  param :id, :number, required: true
  error code: 404, desc: MissingRecordDetection::Messages.not_found

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
    @org_params = params.permit(:name, :description, :image)
  end

  def load_organization
    @organization = Organization.find(params.require(:id))
  end

  def load_organizations
    @organizations = query_with_includes Organization.all
  end
end
