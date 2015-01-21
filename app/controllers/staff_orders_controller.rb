class StaffOrdersController < ApplicationController
  respond_to :json

  before_action :load_staff, only: [:show, :index]
  before_action :load_order, only: [:show]
  before_action :load_orders, only: [:index]

  api :GET, '/staff/:staff_id/orders', 'Returns a collection of orders for a member'
  param :staff_id, :number, required: true
  param :includes, Array, required: false, in: %w(order_items)
  param :methods, Array, required: false, in: %w(item_count)
  param :page, :number, required: false
  param :per_page, :number, required: false

  def index
    if @orders
      respond_with_params @orders
    else
      record_not_found
    end
  end

  api :GET, '/staff/:staff_id/orders/:id', 'Returns a collection of orders for a member'
  param :includes, Array, required: false, in: %w(order_items)
  param :methods, Array, required: false, in: %w(item_count)
  param :id, :number, required: true
  param :staff_id, :number, required: true
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def show
    if @order
      respond_with_params @order
    else
      record_not_found
    end
  end

  protected

  def load_staff
    @staff = Staff.find(params.require(:staff_id))
  end

  def load_order
    @order = @staff.orders.where(id: params.require(:id)).first unless @staff.nil?
  end

  def load_orders
    @orders = query_with @staff.orders, :includes, :pagination unless @staff.nil?
  end
end
