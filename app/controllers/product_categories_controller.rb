class ProductCategoriesController < ApplicationController
  respond_to :json

  after_action :verify_authorized

  before_action :load_product_category, only: [:show, :update, :destroy, :start_service, :stop_service]
  before_action :load_product_category_params, only: [:create, :update]
  before_action :load_product_categories, only: [:index]

  api :GET, '/product_categories', 'Returns a collection of product_categories'
  param :includes, Array, required: false, in: %w(product cloud)

  def index
    authorize ProductCategory
    respond_with_params @product_categories
  end

  api :GET, '/product_categories/:id', 'Shows product_category with :id'
  param :includes, Array, required: false, in: %w(product cloud)
  param :id, :number, required: true
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def show
    authorize @product_category
    respond_with_params @product_category
  end

  api :POST, '/product_categories', 'Creates product_category'
  param :options, Array, desc: 'Options'
  error code: 422, desc: ParameterValidation::Messages.missing

  def create
    @product_category = ProductCategory.new @product_categories_params

    authorize @product_category

    if @product_category.save
      respond_with @product_category
    else
      respond_with @product_category.errors, status: :unprocessable_entity
    end
  end

  api :PUT, '/product_categories/:id', 'Updates product_category with :id'
  param :id, :number, required: true
  param :options, Array, desc: 'Options'
  error code: 404, desc: MissingRecordDetection::Messages.not_found
  error code: 422, desc: ParameterValidation::Messages.missing

  def update
    authorize @product_category

    if @product_category.update_attributes @product_categories_params
      render json: @product_category
    else
      respond_with @product_category.errors, status: :unprocessable_entity
    end
  end

  api :DELETE, '/product_categories/:id', 'Deletes product_category with :id'
  param :id, :number, required: true
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def destroy
    authorize @product_category
    if @product_category.destroy
      render json: @product_category
    else
      respond_with @product_category.errors, status: :unprocessable_entity
    end
  end

  private

  def load_product_category_params
    @product_categories_params = params.permit(:product_id, :project_id, :staff_id, :cloud_id, options: [])
  end

  def load_product_category
    @product_category = ProductCategory.find(params.require(:id))
  end

  def load_product_categories
    @product_categories = query_with_includes ProductCategory.all
  end
end
