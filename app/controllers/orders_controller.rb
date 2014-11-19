class OrdersController < ApplicationController
  extend Apipie::DSL::Concern
  include MissingRecordDetection::Concern
  include ParameterValidation::Concern

  respond_to :json

  before_action :load_order, only: [:show, :update, :destroy]
  before_action :load_order_params, only: [:create, :update]
  before_action :load_orders, only: [:index]

  api :GET, '/orders', 'Returns a collection of orders'

  def index
    respond_with @orders
  end

  api :GET, '/orders/:id', 'Shows order with :id'
  param :id, :number, required: true
  error code: 404, desc: MissingRecordDetection::Concern.NOT_FOUND_MESSAGE

  def show
    respond_with @order
  end

  api :POST, '/orders', 'Creates order'
  param :order, Hash, desc: 'Order' do
    param :options, Array, desc: 'Options'
  end
  error code: 422, desc: ParameterValidation::Concern.MISSING_PARAMETER_MESSAGE

  def create
    @order = Order.new @orders_params

    if @order.save
      respond_with @order
    else
      respond_with @order.errors, status: :unprocessable_entity
    end
  end

  api :PUT, '/orders/:id', 'Updates order with :id'
  param :id, :number, required: true
  param :order, Hash, desc: 'Order' do
    param :options, Hash, desc: 'Name'
  end
  error code: 404, desc: MissingRecordDetection::Concern.NOT_FOUND_MESSAGE
  error code: 422, desc: ParameterValidation::Concern.MISSING_PARAMETER_MESSAGE

  def update
    @order.update_attributes(@orders_params)

    if @order.save
      render json: @order
    else
      respond_with @order.errors, status: :unprocessable_entity
    end
  end

  api :DELETE, '/orders/:id', 'Deletes order with :id'
  param :id, :number, required: true
  error code: 404, desc: MissingRecordDetection::Concern.NOT_FOUND_MESSAGE

  def destroy
    if @order.destroy
      render json: @order
    else
      respond_with @order.errors, status: :unprocessable_entity
    end
  end

  private

  def load_order_params
    @orders_params = params.require(:order).permit(options: [])
  end

  def load_order
    @order = Order.find(params.require(:id))
  end

  def load_orders
    @orders = Order.all
  end
end
