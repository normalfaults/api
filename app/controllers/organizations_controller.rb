class OrganizationsController < ApplicationController
  respond_to :json

  before_action :load_organization, only: [:show, :update]
  before_action :load_org_params, only: [:create, :update]
  before_action :load_organizations, only: [:index]

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActionController::ParameterMissing, with: :param_missing

  def index
    render json: @organizations
  end

  def show
    render json: @organization
  end

  def create
    @organization = Organization.create(@org_params)

    if @organization
      render json: @organization
    else
      render json: @organization.errors, status: 422
    end
  end

  def update
    @organization.update_attributes(@org_params)

    if @organization.save
      render json: @organization
    else
      render json: @organization.errors, status: 422
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
    render json: { error: 'Not found.' }, status: 404
  end
end
