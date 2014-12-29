class Provision::VmsController < ApplicationController
  respond_to :json

  after_action :verify_authorized

  before_action :load_vm, only: [:show, :update, :destroy]
  before_action :load_vm_params, only: [:create, :update]
  before_action :load_vms, only: [:index]

  #layout false

  api :GET, '/provision/vms', 'Returns a collection of virtual machines'
  param :includes, Array, required: false, in: %w(chargebacks orders products)

  def index
    authorize Provision
    #respond_with_params @vms
    #render :text => @vms.inspect
    #respond_with_params ManageIQClient::VirtualMachine.list
    render ManageIQClient::VirtualMachine.list
  end

  #api :GET, '/provision/vms/:id', 'Shows virtual machine with :id'
  #param :id, :number, required: true
  #param :includes, Array, required: false, in: %w(chargebacks orders products)
  #error code: 404, desc: MissingRecordDetection::Messages.not_found

  #def show
  #  authorize @vm
  #  respond_with_params @vm
  #end

  #api :POST, '/provision/vms', 'Creates a virtual machine provision'
  #param :vm, Hash, desc: 'VM' do
  #  param :name, String, required: false
  #  param :desciption, String, required: false
  #  param :extra, String, required: false
  #end
  #error code: 422, desc: ParameterValidation::Messages.missing

  #def create
  #  @vm = Provision.new @vm_params
  #  authorize @vm
  #  if @vm.save
  #    render json: @vm
  #  else
  #    respond_with @vm.errors, status: :unprocessable_entity
  #  end
  #end

  #api :PUT, '/provision/vm/:id', 'Updates virtual machine with :id'
  #param :id, :number, required: true
  #param :vm, Hash, desc: 'VM' do
  #  param :name, String, required: false
  #  param :desciption, String, required: false
  #  param :extra, String, required: false
  #end
  #error code: 404, desc: MissingRecordDetection::Messages.not_found
  #error code: 422, desc: ParameterValidation::Messages.missing

  #def update
  #  @vm.update_attributes @vm_params
  #  authorize @vm
  #  if @vm.save
  #    render json: @vm
  #  else
  #    respond_with @vm.errors, status: :unprocessable_entity
  #  end
  #end

  #api :DELETE, '/provision/vm/:id', 'Deletes virtual machine with :id'
  #param :id, :number, required: true
  #error code: 404, desc: MissingRecordDetection::Messages.not_found

  #def destroy
  #  authorize @vm
  #  if @vm.destroy
  #    respond_with @vm
  #  else
  #    respond_with @vm.errors, status: :unprocessable_entity
  #  end
  #end

  private

  def load_vm_params
    @vm_params = params.require(:vm).permit(:name, :description, :extra)
  end

  #def load_vm
  #  @vm = Provision.find(params.require(:id))
  #end

  def load_vms
    #@vms = query_with_includes Provision.vm
    @vms = ManageIQClient::VirtualMachine.list
  end
end