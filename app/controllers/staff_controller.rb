class StaffController < ApplicationController
  respond_to :json, :xml

  after_action :verify_authorized

  before_action :load_staffs, only: [:index]
  before_action :load_staff, only: [:show, :update, :destroy, :projects, :add_project, :remove_project]
  before_action :load_project, only: [:add_project, :remove_project]
  before_action :load_staff_params, only: [:create, :update]

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActionController::ParameterMissing, with: :param_missing

  def index
    authorize Staff.new
    respond_with @staffs
  end

  def show
    authorize @staff
    respond_with @staff
  end

  def create
    @staff = Staff.new @staff_params
    authorize @staff
    if @staff.save
      respond_with @staff
    else
      respond_with @staff.errors, status: :unprocessable_entity
    end
  end

  def update
    authorize @staff
    if @staff.update_attributes @staff_params
      respond_with @staff
    else
      respond_with @staff.errors, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @staff
    if @staff.destroy
      respond_with @staff
    else
      respond_with @staff.errors, status: :unprocessable_entity
    end
  end

  def projects
    authorize @staff
    respond_with @staff.projects
  end

  def add_project
    authorize @staff
    if @staff.projects << @project
      respond_with @project
    else
      respond_with @staff.errors, status: :unprocessable_entity
    end
  end

  def remove_project
    authorize @staff
    if @staff.projects.delete @project
      respond_with @project
    else
      respond_with @staff.errors, status: :unprocessable_entity
    end
  end

  private

  def load_staffs
    # TODO: Use a FormObject to encapsulate search filters, ordering, pagination
    @staffs = Staff.all
  end

  def load_staff_params
    @staff_params = params.require(:staff).permit(:first_name, :last_name, :email, :role, :password, :password_confirmation)
  end

  def load_staff
    @staff = Staff.find params.require(:id)
  end

  def load_project
    @project = Project.find params[:project_id]
  end

  def record_not_found
    render json: { error: 'Not found.' }, status: 404
  end

  def param_missing(e)
    render json: { error: e.message }, status: 422
  end
end
