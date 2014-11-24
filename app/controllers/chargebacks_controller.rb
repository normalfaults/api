class ChargebacksController < ApplicationController
  extend Apipie::DSL::Concern
  include MissingRecordDetection
  include ParameterValidation
  include AssociationResolution

  respond_to :json

  after_action :verify_authorized

  before_action :load_chargeback, only: [:show, :update, :destroy]
  before_action :load_chargeback_params, only: [:create, :update]
  before_action :load_chargebacks, only: [:index]

  api :GET, '/chargebacks', 'Returns a collection of chargebacks'
  param :include, Array, required: false, in: ['cloud', 'product']

  def index
    authorize Chargeback
    respond_with_resolved_associations @chargebacks
  end

  api :GET, '/chargebacks/:id', 'Shows chargeback with :id'
  param :id, :number, required: true
  param :include, Array, required: false, in: ['cloud', 'product']
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def show
    authorize @chargeback
    respond_with_resolved_associations @chargeback
  end

  api :POST, '/chargebacks', 'Creates a chargeback'
  param :chargeback, Hash, desc: 'Chargeback' do
    param :product_id, :number, required: false
    param :cloud_id, :number, required: false
    param :hourly_price, :number, required: false
  end
  error code: 422, desc: ParameterValidation::Messages.missing

  def create
    @chargeback = Chargeback.new @chargeback_params
    authorize @chargeback
    if @chargeback.save
      render json: @chargeback
    else
      respond_with @chargeback.errors, status: :unprocessable_entity
    end
  end

  api :PUT, '/chargeback/:id', 'Updates chargeback with :id'
  param :id, :number, required: true
  param :chargeback, Hash, desc: 'Chargeback' do
    param :product_id, :number, required: false
    param :cloud_id, :number, required: false
    param :hourly_price, :number, required: false
  end
  error code: 404, desc: MissingRecordDetection::Messages.not_found
  error code: 422, desc: ParameterValidation::Messages.missing

  def update
    @chargeback.update_attributes @chargeback_params
    authorize @chargeback
    if @chargeback.save
      render json: @chargeback
    else
      respond_with @chargeback.errors, status: :unprocessable_entity
    end
  end

  api :DELETE, '/chargeback/:id', 'Deletes chargeback with :id'
  param :id, :number, required: true
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def destroy
    authorize @chargeback
    if @chargeback.destroy
      respond_with @chargeback
    else
      respond_with @chargeback.errors, status: :unprocessable_entity
    end
  end

  private

  def load_chargeback_params
    @chargeback_params = params.require(:chargeback).permit(:hourly_price, :cloud_id, :product_id)
  end

  def load_chargeback
    @chargeback = Chargeback.find(params.require(:id))
  end

  def load_chargebacks
    @chargebacks = Chargeback.all
  end
end
