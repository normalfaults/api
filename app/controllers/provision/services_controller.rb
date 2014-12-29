class ServicesController < ProvisionController
  before_action :load_service, only: [:show, :update, :destroy]
  before_action :load_service_params, only: [:create, :update]
  before_action :load_services, only: [:index]

  api :GET, '/provision/services', 'Returns a collection of services'
  param :includes, Array, required: false, in: %w(chargebacks orders products)

  def index
    authorize Provision
    respond_with_params @services
  end

  api :GET, '/provision/services/:id', 'Shows service with :id'
  param :id, :number, required: true
  param :includes, Array, required: false, in: %w(chargebacks orders products)
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def show
    authorize @service
    respond_with_params @service
  end

  api :POST, '/provision/services', 'Creates a service provision'
  param :service, Hash, desc: 'Service' do
    param :name, String, required: false
    param :desciption, String, required: false
    param :extra, String, required: false
  end
  error code: 422, desc: ParameterValidation::Messages.missing

  def create
    @service = Provision.new @service_params
    authorize @service
    if @service.save
      render json: @service
    else
      respond_with @service.errors, status: :unprocessable_entity
    end
  end

  api :PUT, '/provision/service/:id', 'Updates service with :id'
  param :id, :number, required: true
  param :service, Hash, desc: 'Service' do
    param :name, String, required: false
    param :desciption, String, required: false
    param :extra, String, required: false
  end
  error code: 404, desc: MissingRecordDetection::Messages.not_found
  error code: 422, desc: ParameterValidation::Messages.missing

  def update
    @service.update_attributes @service_params
    authorize @service
    if @service.save
      render json: @service
    else
      respond_with @service.errors, status: :unprocessable_entity
    end
  end

  api :DELETE, '/provision/service/:id', 'Deletes service with :id'
  param :id, :number, required: true
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def destroy
    authorize @service
    if @service.destroy
      respond_with @service
    else
      respond_with @service.errors, status: :unprocessable_entity
    end
  end

  private

  def load_service_params
    @service_params = params.require(:service).permit(:name, :description, :extra)
  end

  def load_service
    @service = Provision.find(params.require(:id))
  end

  def load_clouds
    @services = query_with_includes Provision.all
  end
end