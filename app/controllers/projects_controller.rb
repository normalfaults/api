class ProjectsController < ApplicationController
  respond_to :json, :xml

  after_action :verify_authorized

  before_action :load_projects, only: [:index]
  before_action :load_project, only: [:show, :update, :destroy, :staff, :add_staff, :remove_staff]
  before_action :load_staff, only: [:add_staff, :remove_staff]
  before_action :load_project_params, only: [:create, :update]

  api :GET, '/projects', 'Returns a collection of projects'
  param :include, Array, required: false, in: %w(staff project_answers)

  def index
    authorize Project.new
    respond_with_resolved_associations @projects
  end

  api :GET, '/projects/:id', 'Shows project with :id'
  param :id, :number, required: true
  param :include, Array, required: false, in: %w(staff project_answers)
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def show
    authorize @project
    respond_with_resolved_associations @project
  end

  api :POST, '/projects', 'Creates projects'
  param :project, Hash, desc: 'Project' do
    param :project_answers, Array, desc: 'Project answers', required: false do
      param :project_question_id, :number, desc: 'Id for valid project question', require: true
    end
    param :name, String, required: false
    param :description, String, required: false
    param :cc, String, required: false
    param :budget, :number, required: false
    param :staff_id, String, required: false
    param :end_data, Date, required: false
    param :approved, String, required: false
    param :img, String, required: false
  end
  param :include, Array, required: false, in: %w(staff project_answers)
  error code: 422, desc: MissingRecordDetection::Messages.not_found

  def create
    authorize Project

    @project = Project.create_with_answers @project_params

    if @project
      respond_with_resolved_associations @project
    else
      respond_with @project.errors, status: :unprocessable_entity
    end
  end

  api :PUT, '/projects/:id', 'Updates project with :id'
  param :id, :number, required: true
  param :project, Hash, desc: 'Project' do
    param :name, String, required: false
    param :description, String, required: false
    param :cc, String, required: false
    param :budget, :number, required: false
    param :staff_id, String, required: false
    param :end_data, Date, required: false
    param :approved, String, required: false
    param :img, String, required: false
  end
  error code: 404, desc: MissingRecordDetection::Messages.not_found
  error code: 422, desc: ParameterValidation::Messages.missing

  def update
    authorize @project
    if @project.update_attributes @project_params
      respond_with @project
    else
      respond_with @project.errors, status: :unprocessable_entity
    end
  end

  api :DELETE, '/projects/:id', 'Deletes project with :id'
  param :id, :number, required: true
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def destroy
    authorize @project
    if @project.destroy
      respond_with @project
    else
      respond_with @project.errors, status: :unprocessable_entity
    end
  end

  api :GET, '/projects/:id/staff', 'Shows collection of staff for a project :id'
  param :id, :number, required: true
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def staff
    authorize @project
    respond_with @project.staff
  end

  api :POST, '/projects/:id/staff/:staff_id', 'Adds staff to a project'
  param :id, :number, required: true
  param :staff_id, :number, desc: 'Staff'
  error code: 422, desc: MissingRecordDetection::Messages.not_found

  def add_staff
    authorize @project
    if @project.staff << @staff
      respond_with @staff
    else
      respond_with @project.errors, status: :unprocessable_entity
    end
  end

  api :DELETE, '/projects/:id/staff/:staff_id', 'Deletes staff from a project'
  param :id, :number, required: true
  param :staff, Hash, desc: 'Staff' do
    param :id, :number, required: true
  end
  error code: 404, desc: MissingRecordDetection::Messages.not_found

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
    @project_params = params.require(:project).permit(:name, :description, :cc, :budget, :staff_id, :start_date, :end_data, :approved, :img, project_answers: [:project_question_id, :answer])
  end

  def load_project
    @project = Project.find params.require(:id)
  end

  def load_staff
    @staff = Staff.find params.require(:staff_id)
  end
end
