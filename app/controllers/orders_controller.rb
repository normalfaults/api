class OrdersController < ApplicationController
  respond_to :json

  before_action :load_order, only: [:show, :update, :destroy]
  before_action :load_order_params, only: [:create, :update]
  before_action :load_orders, only: [:index]

  api :GET, '/orders', 'Returns a collection of orders'
  param :include, Array, required: false, in: %w(staff product project cloud chargebacks)

  def index
    respond_with_resolved_associations @orders
  end

  api :GET, '/orders/:id', 'Shows order with :id'
  param :include, Array, required: false, in: %w(staff product project cloud chargebacks)
  param :id, :number, required: true
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def show
    respond_with_resolved_associations @order
  end

  api :POST, '/orders', 'Creates order'
  param :order, Hash, desc: 'Order' do
    param :options, Array, desc: 'Options'
  end
  error code: 422, desc: ParameterValidation::Messages.missing

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
    param :options, Array, desc: 'Options'
  end
  error code: 404, desc: MissingRecordDetection::Messages.not_found
  error code: 422, desc: ParameterValidation::Messages.missing

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
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def destroy
    if @order.destroy
      render json: @order
    else
      respond_with @order.errors, status: :unprocessable_entity
    end
  end

  private

  def load_order_params
    @orders_params = params.require(:order).permit(:product_id, :project_id, :staff_id, :cloud_id, options: [])
  end

  def load_order
    @order = Order.find(params.require(:id))
  end

  def load_orders
    @orders = Order.all
  end
end
