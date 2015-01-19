class ProductTypesController < ApplicationController
  respond_to :json

  after_action :verify_authorized

  before_action :load_product_type, only: [:show, :update, :destroy, :start_service, :stop_service]
  before_action :load_product_type_params, only: [:create, :update]
  before_action :load_product_types, only: [:index]
  before_action :load_questions, only: [:questions]

  api :GET, '/product_types', 'Returns a collection of product_types'
  param :includes, Array, required: false, in: %w(product cloud questions)

  def index
    authorize ProductType
    respond_with_params @product_types
  end

  api :GET, '/product_types/:id', 'Shows product_type with :id'
  param :includes, Array, required: false, in: %w(product cloud questions)
  param :id, :number, required: true
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def show
    authorize @product_type
    respond_with_params @product_type
  end

  api :POST, '/product_types', 'Creates product_type'
  param :options, Array, desc: 'Options'
  error code: 422, desc: ParameterValidation::Messages.missing

  def create
    @product_type = ProductType.new @product_types_params
    authorize @product_type
    @product_type.save
    respond_with @product_type
  end

  api :PUT, '/product_types/:id', 'Updates product_type with :id'
  param :id, :number, required: true
  param :options, Array, desc: 'Options'
  error code: 404, desc: MissingRecordDetection::Messages.not_found
  error code: 422, desc: ParameterValidation::Messages.missing

  def update
    authorize @product_type
    @product_type.update_attributes @product_types_params
    respond_with @product_type
  end

  api :DELETE, '/product_types/:id', 'Deletes product_type with :id'
  param :id, :number, required: true
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def destroy
    authorize @product_type
    @product_type.destroy
    respond_with @product_type
  end

  def questions
    authorize @product_type
    respond_with @questions
  end

  private

  def load_product_type_params
    @product_types_params = params.permit(:product_id, :project_id, :staff_id, :cloud_id, options: [])
  end

  def load_product_type
    @product_type = ProductType.find(params.require(:id))
  end

  def load_product_types
    @product_types = query_with_includes ProductType.all
  end

  def load_questions
    load_product_type
    @questions = @product_type.questions
  end
end
