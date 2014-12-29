class OrdersController < ApplicationController
  respond_to :json

  after_action :verify_authorized

  before_action :load_order, only: [:show, :update, :destroy, :start_service, :stop_service]
  before_action :load_order_params, only: [:create, :update]
  before_action :load_orders, only: [:index]

  api :GET, '/orders', 'Returns a collection of orders'
  param :includes, Array, required: false, in: %w(order_items)

  def index
    authorize Order
    respond_with_params @orders
  end

  api :GET, '/orders/:id', 'Shows order with :id'
  param :includes, Array, required: false, in: %w(order_items)
  param :id, :number, required: true
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def show
    authorize @order
    respond_with_params @order
  end

  api :POST, '/orders', 'Creates order'
  param :order, Hash, desc: 'Order' do
    param :staff_id, :number, required: true
    param :total, :real_number, required: false
    param :order_items, Array, desc: 'Order Items', required: false do
      param :project_id, :number, desc: 'Id for Project', require: true
      param :product_id, :number, desc: 'Id for Product', require: true
    end
    param :options, Array, desc: 'Options'
  end
  error code: 422, desc: ParameterValidation::Messages.missing

  def create
    @order = Order.new @orders_params

    authorize @order

    if @order.save
      respond_with @order
    else
      respond_with @order.errors, status: :unprocessable_entity
    end
  end

  api :PUT, '/orders/:id', 'Updates order with :id'
  param :id, :number, required: true
  param :order, Hash, desc: 'Order' do
    param :project_id, :number, required: true
    param :staff_id, :number, required: true
    param :options, Array, desc: 'Options'
    param :total, :real_number, required: false
  end
  error code: 404, desc: MissingRecordDetection::Messages.not_found
  error code: 422, desc: ParameterValidation::Messages.missing

  def update
    authorize @order

    if @order.update_attributes @orders_params
      render json: @order
    else
      respond_with @order.errors, status: :unprocessable_entity
    end
  end

  api :DELETE, '/orders/:id', 'Deletes order with :id'
  param :id, :number, required: true
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def destroy
    authorize @order
    if @order.destroy
      render json: @order
    else
      respond_with @order.errors, status: :unprocessable_entity
    end
  end

  protected

  def load_order_params
    @orders_params = params.require(:order).permit(:product_id, :project_id, :staff_id, :cloud_id, options: [])
  end

  def load_order
    @order = Order.find(params.require(:id))
  end

  def load_orders
    @orders = query_with_includes Order.all
  end
end
