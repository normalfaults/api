class ProductsController < ApplicationController
  skip_before_action :authenticate_user_from_token!

  respond_to :json

  before_action :load_product, only: [:show, :update, :destroy]
  before_action :load_product_params, only: [:create, :update]
  before_action :load_products, only: [:index]

  api :GET, '/products', 'Returns a collection of products'
  param :page, :number, required: false
  param :per_page, :number, required: false
  param :includes, Array, required: false, in: %w(chargebacks cloud product_category)

  def index
    respond_with_params @products
  end

  api :GET, '/products/:id', 'Shows product with :id'
  param :id, :number, required: true
  param :includes, Array, required: false, in: %w(chargebacks cloud product_category)
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def show
    respond_with_params @product
  end

  api :POST, '/products', 'Creates product'
  param :name, String, desc: 'Product Name'
  param :description, String, desc: 'Short description'
  param :service_catalog_id, Integer, desc: 'ManageIQ Catalog Id'
  param :service_type_id, Integer, desc: 'ManageIQ Catalog Item Id'
  param :product_category_id, Integer, desc: 'ProductCategory Id'
  param :cloud_id, Integer, desc: 'Cloud Id'
  param :options, Array, desc: 'Options', allow_nil: true
  error code: 422, desc: ParameterValidation::Messages.missing

  def create
    @product = Product.new @products_params
    @product.save
    respond_with @product
  end

  api :PUT, '/products/:id', 'Updates product with :id'
  param :id, :number, required: true
  param :name, String, desc: 'Product Name'
  param :description, String, desc: 'Short description'
  param :service_catalog_id, Integer, desc: 'ManageIQ Catalog Id'
  param :service_type_id, Integer, desc: 'ManageIQ Catalog Item Id'
  param :product_category_id, Integer, desc: 'ProductCategory Id'
  param :cloud_id, Integer, desc: 'Cloud Id'
  param :options, Array, desc: 'options', allow_nil: true
  error code: 404, desc: MissingRecordDetection::Messages.not_found
  error code: 422, desc: ParameterValidation::Messages.missing

  def update
    @product.update_attributes(@products_params)
    @product.save
    respond_with @product
  end

  api :DELETE, '/products/:id', 'Deletes product with :id'
  param :id, :number, required: true
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def destroy
    @product.destroy
    respond_with @product
  end

  private

  def load_product_params
    @products_params = params.permit(:name, :description, :service_type_id, :service_catalog_id, :product_category_id, :cloud_id, { options: [] }, :img, :active)
  end

  def load_product
    @product = Product.find(params.require(:id))
  end

  def load_products
    @products = query_with Product.all, :includes, :pagination
  end
end
