class OrdersController < ApplicationController
  after_action :verify_authorized

  before_action :load_order, only: [:show, :update, :destroy]
  before_action :load_order_params, only: [:create, :update]
  before_action :load_orders, only: [:index]
  before_action :load_order_items, only: [:items]

  api :GET, '/orders', 'Returns a collection of orders'
  param :page, :number, required: false
  param :per_page, :number, required: false
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
  param :order_items, Array, desc: 'Order Items', required: false do
    param :project_id, :number, desc: 'Id for Project', require: true
    param :product_id, :number, desc: 'Id for Product', require: true
    param :cloud_id, :number, desc: 'Id for cloud', require: false
    param :port, :number, required: false
    param :host, String, required: false
    param :provision_status, %w(pending active), required: false
  end
  param :staff_id, :number, required: true
  param :total, :real_number, required: false
  param :options, Array, desc: 'Options'
  error code: 422, desc: ParameterValidation::Messages.missing

  def create
    authorize Order
    @order = Order.create @orders_params
    respond_with @order
  end

  api :PUT, '/orders/:id', 'Updates order with :id'
  param :id, :number, required: true
  param :order_items, Array, desc: 'Order Items', required: false do
    param :id, :number, desc: 'Id for Project', require: true
    param :project_id, :number, desc: 'Id for Project', require: true
    param :product_id, :number, desc: 'Id for Product', require: true
    param :cloud_id, :number, desc: 'Id for cloud', require: false
    param :port, :number, required: false
    param :host, String, required: false
    param :provision_status, %w(pending active), required: false
  end
  param :staff_id, :number, required: true
  param :options, Array, desc: 'Options'
  param :total, :real_number, required: false
  error code: 404, desc: MissingRecordDetection::Messages.not_found
  error code: 422, desc: ParameterValidation::Messages.missing

  def update
    authorize @order
    @order.update @orders_params
    respond_with @order
  end

  api :DELETE, '/orders/:id', 'Deletes order with :id'
  param :id, :number, required: true
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def destroy
    authorize @order
    @order.destroy
    respond_with @order
  end

  api :GET, '/orders/:id/items', 'Gets a list of order items for the order'
  param :id, :number, required: true
  param :page, :number, required: false
  param :per_page, :number, required: false
  param :includes, Array, required: false, in: %w(product latest_alert)

  def items
    authorize @order
    respond_with_params @order_items
  end

  protected

  def load_order_params
    @orders_params = params.permit(:total, :staff_id, options: [], order_items: [:project_id, :product_id, :cloud_id, :id])
    @orders_params[:order_items_attributes] = @orders_params[:order_items] unless @orders_params[:order_items].nil?
    @orders_params.delete(:order_items) unless @orders_params[:order_items].nil?
  end

  def load_order
    @order = Order.find(params.require(:id))
  end

  def load_orders
    @orders = query_with Order.all, :includes, :pagination
  end

  def load_order_items
    @order = Order.find params.require(:id)
    @order_items = query_with OrderItem.where(order_id: @order.id), :includes, :pagination
  end
end
