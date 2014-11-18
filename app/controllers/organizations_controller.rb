class OrganizationsController < ApplicationController
  extend Apipie::DSL::Concern

  respond_to :json

  before_action :load_organization, only: [:show, :update]
  before_action :load_org_params, only: [:create, :update]
  before_action :load_organizations, only: [:index]

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActionController::ParameterMissing, with: :param_missing

  api :GET, '/organizations', 'Returns a collection of organizations'
  example '[{"id":1,"name":"123","description":null,"img":null,"created_at":"2014-11-17T18:33:04.202Z","updated_at":"2014-11-17T18:48:47.829Z"}]'

  def index
    render json: @organizations
  end

  api :GET, '/organizations/:id', 'Shows organization with :id'
  param :id, :number, required: true
  error :code => 404, :desc => "Not Found"
  example '{"id":1,"name":"123","description":null,"img":null,"created_at":"2014-11-17T18:33:04.202Z","updated_at":"2014-11-17T18:48:47.829Z"}'

  def show
    render json: @organization
  end

  api :POST, '/organizations', 'Creates organization'
  param :organization, Hash, :desc => "Organization" do
    param :name, String, :desc => "Name"
    param :image, String, :desc => "Image URL"
    param :description, String, :desc => "Description of organization"
  end
  error :code => 422, :desc => "Missing parameter"
  example '{"id":10,"name":"test","description":null,"img":null,"created_at":"2014-11-17T22:49:05.425Z","updated_at":"2014-11-17T22:49:05.425Z"}'

  def create
    @organization = Organization.create(@org_params)

    if @organization
      render json: @organization
    else
      render json: @organization.errors, status: 422
    end
  end

  api :PUT, '/organizations/:id', 'Updates organization with :id'
  param :id, :number, required: true
  param :organization, Hash, :desc => "Organization" do
    param :name, String, :desc => "Name"
    param :image, String, :desc => "Image URL"
    param :description, String, :desc => "Description of organization"
  end
  error :code => 404, :desc => "Not Found"
  error :code => 422, :desc => "Missing parameter"
  example '{"id":1,"name":"test","description":null,"img":null,"created_at":"2014-11-17T18:33:04.202Z","updated_at":"2014-11-17T22:49:44.689Z"}'

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
