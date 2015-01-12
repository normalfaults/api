class OrderItemsController < ApplicationController
  respond_to :json

  before_action :load_order_item, only: [:show, :destroy, :update, :start_service, :stop_service]
  before_action :load_order_item_for_provision_update, only: [:provision_update]

  api :GET, '/orders/:order_id/items/:id', 'Shows order item with :id'
  param :includes, Array, required: false, in: %w(product)
  param :id, :number, required: true
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def show
    # @todo: add policy for order item
    # authorize @order
    if @order_item
      respond_with_params @order_item
    else
      record_not_found
    end
  end

  api :DELETE, '/orders/:order_id/items/:id', 'Deletes order item with :id'
  param :id, :number, required: true
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def destroy
    # @todo: add policy for order item
    # authorize @order
    if @order_item
      @order_item.destroy
      respond_with @order_item
    else
      record_not_found
    end
  end

  api :PUT, '/orders/:order_id/items/:id', 'Updates order item with :id'
  param :id, :number, required: true
  param :order_id, :number, required: true
  param :port, :number, required: false
  param :host, String, required: false
  param :provision_status, %w(pending active)

  error code: 404, desc: MissingRecordDetection::Messages.not_found
  error code: 422, desc: ParameterValidation::Messages.missing

  def update
    @order_item.update_attributes order_item_params
    respond_with @order_item
  end

  api :PUT, '/orders/:order_id/items/:id/start_service', 'Starts service for order item'
  param :id, :number, required: true

  def start_service
    # @todo: add policy for order item
    # authorize @order_item
    # TODO: Direct ManageIQ to pass along a start request
    render nothing: true, status: :ok
  end

  api :PUT, '/orders/:order_id/items/:id/stop_service', 'Stops service for order item'
  param :id, :number, required: true

  def stop_service
    # @todo: add policy for order item
    # authorize @order_item
    # TODO: Direct ManageIQ to pass along a stop request
    render nothing: true, status: :ok
  end

  api :PUT, '/order_items/:order_item_id', 'Updates an order item using the order item ID'
  param :status, String, required: true
  param :message, String, required: true
  param :info, Hash, required: true do
    param :id, :number, required: true
    param :provision_status, String, required: true
    param :miq_id, :number, required: false
    param :ip_address, String, required: false
    param :hostname, String, required: false
    param :host, String, required: false
    param :port, :number, required: false
  end

  error code: 404, desc: MissingRecordDetection::Messages.not_found
  error code: 422, desc: ParameterValidation::Messages.missing

  def provision_update
    @order_item.update_attributes order_item_params_for_provision_update
    respond_with @order_item
  end

  private

  def order_item_params
    params.permit(:id, :order_id, :port, :host, :provision_status, :ip_address, :hostname)
  end

  def orders_from_params
    OrderItem.where(id: params.require(:id), order_id: params.require(:order_id))
  end

  def load_order_item
    @order_item = orders_from_params.first
  end

  def order_item_params_for_provision_update
    params.require(:info).permit(:id, :miq_id, :provision_status, :ip_address, :hostname, :host, :port)
  end

  def load_order_item_for_provision_update
    @order_item = OrderItem.where(id: params.require(:order_item_id)).first
  end
end
