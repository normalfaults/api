class ProvisionController < ApplicationController
  respond_to :json

  after_action :verify_authorized

  before_action :load_request, only: [:show, :update, :destroy]
  before_action :load_request_params, only: [:create, :update]
  before_action :load_requests, only: [:index]

  api :GET, '/provisions', 'Returns a collection of provision requests'
  param :includes, Array, required: false, in: %w(chargebacks orders products)

  def index
    authorize Provision
    #respond_with_params @vms
    #render :text => @vms.inspect
    #respond_with_params ManageIQClient::Base.new
    render :text => ManageIQClient::VirtualMachine.list().to_s
  end
end