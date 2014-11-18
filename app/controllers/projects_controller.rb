class ProjectsController < ApplicationController
  respond_to :json, :xml

  after_action :verify_authorized

  before_action :load_projects, only: [:index]
  before_action :load_project, only: [:show, :update, :destroy, :staff, :add_staff, :remove_staff]
  before_action :load_staff, only: [:add_staff, :remove_staff]
  before_action :load_project_params, only: [:create, :update]

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActionController::ParameterMissing, with: :param_missing

  def index
    authorize Project.new
    respond_with @projects
  end

  def show
    authorize @project
    respond_with @project
  end

  def create
    @project = Project.new @project_params
    authorize @project
    if @project.save
      respond_with @project
    else
      respond_with @project.errors, status: :unprocessable_entity
    end
  end

  def update
    authorize @project
    if @project.update_attributes @project_params
      respond_with @project
    else
      respond_with @project.errors, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @project
    if @project.destroy
      respond_with @project
    else
      respond_with @project.errors, status: :unprocessable_entity
    end
  end

  def staff
    authorize @project
    respond_with @project.staff
  end

  def add_staff
    authorize @project
    if @project.staff << @staff
      respond_with @staff
    else
      respond_with @project.errors, status: :unprocessable_entity
    end
  end

  def remove_staff
    authorize @project
    if @project.staff.delete @staff
      respond_with @staff
    else
      respond_with @project.errors, status: :unprocessable_entity
    end
  end

  private

  def load_projects
    # TODO: Use a FormObject to encapsulate search filters, ordering, pagination
    @projects = Project.all
  end

  def load_project_params
    @project_params = params.require(:project).permit(:name, :description, :cc, :budget, :staff_id, :start_date, :end_data, :approved, :img)
  end

  def load_project
    @project = Project.find params.require(:id)
  end

  def load_staff
    @staff = Staff.find params[:staff_id]
  end

  def record_not_found
    render json: { error: 'Not found.' }, status: 404
  end

  def param_missing(e)
    render json: { error: e.message }, status: 422
  end

  # def new
  #   authorize Post.new
  #
  #   json = DummyController.project_new_json
  #   response = {}
  #   response['verb'] = 'GET'
  #   response['route'] = ''
  #   response['status'] = 'OK'
  #   response['applications'] = json['applications']
  #   response['bundles'] = json['bundles']
  #   response['projects'] = json['projects']
  #   response['header'] = json['header']
  #   response['projectValues'] = json['project_values']
  #   response['solutions'] = json['solutions']
  #   response['html'] = json['html']
  #   render json: response.to_json
  # end
  #
  # def show
  #   json = DummyController.project_json(params[:id].to_s)
  #   response = {}
  #   response['verb'] = 'GET'
  #   response['route'] = ''
  #   response['status'] = 'OK'
  #   response[params[:id].to_s] = json[params[:id].to_s]
  #   response['bundles'] = json['bundles']
  #   response['applications'] = json['applications']
  #   response['solutions'] = json['solutions']
  #   response['header'] = json['header']
  #   response['projects'] = json['projects']
  #   response['html'] = json['html']
  #   render json: response.to_json
  # end
end
