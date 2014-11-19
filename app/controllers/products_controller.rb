class ProductsController < ApplicationController
  extend Apipie::DSL::Concern
  include MissingRecordDetection::Concern
  include ParameterValidation::Concern

  respond_to :json

  before_action :load_product, only: [:show, :update, :destroy]
  before_action :load_product_params, only: [:create, :update]
  before_action :load_products, only: [:index]

  api :GET, '/products', 'Returns a collection of products'

  def index
    respond_with @products
  end

  api :GET, '/products/:id', 'Shows product with :id'
  param :id, :number, required: true
  error code: 404, desc: MissingRecordDetection::Concern.NOT_FOUND_MESSAGE

  def show
    respond_with @product
  end

  api :POST, '/products', 'Creates product'
  param :product, Hash, desc: 'Product' do
    param :options, Array, desc: 'Options'
  end
  error code: 422, desc: ParameterValidation::Concern.MISSING_PARAMETER_MESSAGE

  def create
    @product = Order.new @products_params

    if @product.save
      respond_with @product
    else
      respond_with @product.errors, status: :unprocessable_entity
    end
  end

  api :PUT, '/products/:id', 'Updates product with :id'
  param :id, :number, required: true
  param :product, Hash, desc: 'Order' do
    param :options, Hash, desc: 'Name'
  end
  error code: 404, desc: MissingRecordDetection::Concern.NOT_FOUND_MESSAGE
  error code: 422, desc: ParameterValidation::Concern.MISSING_PARAMETER_MESSAGE

  def update
    @product.update_attributes(@products_params)

    if @product.save
      render json: @product
    else
      respond_with @product.errors, status: :unprocessable_entity
    end
  end

  api :DELETE, '/products/:id', 'Deletes product with :id'
  param :id, :number, required: true
  error code: 404, desc: MissingRecordDetection::Concern.NOT_FOUND_MESSAGE

  def destroy
    if @product.destroy
      render json: @product
    else
      respond_with @product.errors, status: :unprocessable_entity
    end
  end

  private

  def load_product_params
    @products_params = params.require(:product).permit(options: [])
  end

  def load_product
    @product = Order.find(params.require(:id))
  end

  def load_products
    @products = Product.all
  end
end