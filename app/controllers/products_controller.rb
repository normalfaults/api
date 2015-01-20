class ProductsController < ApplicationController
  respond_to :json

  after_action :verify_authorized

  before_action :load_product, only: [:show, :update, :destroy]
  before_action :load_product_params, only: [:create, :update]
  before_action :load_products, only: [:index]
  before_action :load_answers, only: [:answers]

  api :GET, '/products', 'Returns a collection of products'
  param :page, :number, required: false
  param :per_page, :number, required: false
  param :active, :bool, required: false
  param :includes, Array, required: false, in: %w(chargebacks cloud product_type answers)

  def index
    authorize Product
    respond_with_params @products
  end

  api :GET, '/products/:id', 'Shows product with :id'
  param :id, :number, required: true
  param :includes, Array, required: false, in: %w(chargebacks cloud product_type answers)
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def show
    authorize @product
    respond_with_params @product
  end

  api :POST, '/products', 'Creates product'
  param :name, String, desc: 'Product Name'
  param :description, String, desc: 'Short description'
  param :service_catalog_id, Integer, desc: 'ManageIQ Catalog Id'
  param :service_type_id, Integer, desc: 'ManageIQ Catalog Item Id'
  param :chef_role, String, desc: 'Chef role'
  param :product_type_id, Integer, desc: 'ProductType Id'
  param :cloud_id, Integer, desc: 'Cloud Id'
  param :options, Array, desc: 'Options', allow_nil: true
  error code: 422, desc: ParameterValidation::Messages.missing

  def create
    @product = Product.new @products_params
    authorize @product
    @product.save
    respond_with @product
  end

  api :PUT, '/products/:id', 'Updates product with :id'
  param :id, :number, required: true
  param :name, String, desc: 'Product Name'
  param :description, String, desc: 'Short description'
  param :service_catalog_id, Integer, desc: 'ManageIQ Catalog Id'
  param :service_type_id, Integer, desc: 'ManageIQ Catalog Item Id'
  param :chef_role, String, desc: 'Chef role'
  param :product_type_id, Integer, desc: 'ProductType Id'
  param :cloud_id, Integer, desc: 'Cloud Id'
  param :active, :bool, desc: 'Product is active and available in the marketplace'
  param :options, Array, desc: 'options', allow_nil: true
  error code: 404, desc: MissingRecordDetection::Messages.not_found
  error code: 422, desc: ParameterValidation::Messages.missing

  def update
    authorize @product
    @product.update_attributes(@products_params)
    respond_with @product
  end

  api :DELETE, '/products/:id', 'Deletes product with :id'
  param :id, :number, required: true
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def destroy
    authorize @product
    @product.destroy
    respond_with @product
  end

  def answers
    authorize @product
    respond_with @answers
  end

  private

  def load_product_params
    @products_params = params.permit(:name, :description, :service_type_id, :service_catalog_id, :chef_role, :product_type_id, :cloud_id, :img, :active, options: [], answers: [:product_id, :product_type_id, :product_type_question_id, :answer, :id])
    # Position the nested answers into a place where they can be handled as nested_attributes
    @products_params.tap do |products|
      products[:answers_attributes] = products.delete(:answers) if products.key?(:answers)
    end
  end

  def load_product
    @product = Product.find(params.require(:id))
  end

  def load_products
    query = Product.all.tap { |q| q.where!(:active => params[:active]) unless params[:active].nil? }
    @products = query_with query, :includes, :pagination
  end

  def load_answers
    load_product
    @answers = @product.answers
  end
end
