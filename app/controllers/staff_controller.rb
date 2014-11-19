class StaffController < ApplicationController
  extend Apipie::DSL::Concern
  include MissingRecordDetection
  include ParameterValidation

  respond_to :json, :xml

  after_action :verify_authorized

  before_action :load_staffs, only: [:index]
  before_action :load_staff, only: [:show, :update, :destroy, :projects, :add_project, :remove_project]
  before_action :load_project, only: [:add_project, :remove_project]
  before_action :load_staff_params, only: [:create, :update]

  api :GET, '/staff', 'Returns a collection of staff'

  def index
    authorize Staff.new
    respond_with @staffs
  end

  api :GET, '/staff/:id', 'Shows staff member with :id'
  param :id, :number, required: true
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def show
    authorize @staff
    respond_with @staff
  end

  api :POST, '/staff', 'Creates a staff member'
  param :staff, Hash, desc: 'Staff' do
  end
  error code: 422, desc: MissingRecordDetection::Messages.not_found

  def create
    @staff = Staff.new @staff_params
    authorize @staff
    if @staff.save
      respond_with @staff
    else
      respond_with @staff.errors, status: :unprocessable_entity
    end
  end

  api :PUT, '/staff/:id', 'Updates a staff member with :id'
  param :id, :number, required: true
  param :staff, Hash, desc: 'Staff' do
  end
  error code: 404, desc: MissingRecordDetection::Messages.not_found
  error code: 422, desc: ParameterValidation::Messages.missing

  def update
    authorize @staff
    if @staff.update_attributes @staff_params
      respond_with @staff
    else
      respond_with @staff.errors, status: :unprocessable_entity
    end
  end

  api :DELETE, '/staff/:id', 'Deletes staff member with :id'
  param :id, :number, required: true
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def destroy
    authorize @staff
    if @staff.destroy
      respond_with @staff
    else
      respond_with @staff.errors, status: :unprocessable_entity
    end
  end

  api :GET, '/staff/:id/project', 'Shows collection of projects for a staff :id'
  param :id, :number, required: true
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def projects
    authorize @staff
    respond_with @staff.projects
  end

  api :POST, '/staff/:id/projects/:project_id', 'Adds project to a staff member'
  param :id, :number, required: true
  param :project_id, :number, desc: 'Project'
  error code: 422, desc: MissingRecordDetection::Messages.not_found

  def add_project
    authorize @staff
    if @staff.projects << @project
      respond_with @project
    else
      respond_with @staff.errors, status: :unprocessable_entity
    end
  end

  api :DELETE, '/staff/:id/project/:project_id', 'Deletes project from a staff'
  param :id, :number, required: true
  param :staff, Hash, desc: 'Staff' do
    param :id, :number, required: true
  end
  error code: 404, desc: MissingRecordDetection::Messages.not_found

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
    @project = Project.find params.require(:project_id)
  end
end
