class ProjectsController < ApplicationController
  PROJECT_FIELDS = %w(alerts approvals approvers latest_alerts project_answers project_detail services staff)
  PROJECT_METHODS = %w(account_number cpu domain hdd icon monthly_spend order_history problem_count ram resources resources_unit state state_ok status url users)
  after_action :verify_authorized

  before_action :load_project_questions, only: [:show]
  before_action :load_projects, only: [:index]
  before_action :load_project, only: [:show, :update, :destroy, :staff, :add_staff, :remove_staff, :approvals, :approve, :reject]
  before_action :load_staff, only: [:add_staff, :remove_staff]
  before_action :load_project_params, only: [:create, :update]
  before_action :load_approval, only: [:approve, :reject]
  before_action :load_rejection_params, only: [:reject]

  def self.document_project_params
    with_options required: false do |api|
      api.param :approved, String
      api.param :budget, :real_number, required: true
      api.param :cc, String
      api.param :description, String
      api.param :end_date, String
      api.param :img, String
      api.param :name, String, required: true
      api.param :project_answers, Array, desc: 'Project answers' do
        api.param :project_question_id, :number, desc: 'Id for valid project question', require: true
      end
      api.param :staff_id, String
    end
  end

  api :GET, '/projects', 'Returns a collection of projects'
  with_options required: false do |api|
    api.param :includes, Array, in: PROJECT_FIELDS
    api.param :methods, Array, in: PROJECT_METHODS
    api.param :page, :number
    api.param :per_page, :number
  end

  def index
    authorize Project.new
    if render_params[:include] && render_params[:include][:project_answers]
      render_params[:include][:project_answers][:include] = :project_question
    end
    respond_with_params @projects
  end

  api :GET, '/projects/:id', 'Shows project with :id'
  param :id, :number, required: true
  param :includes, Array, required: false, in: PROJECT_FIELDS
  param :methods, Array, required: false, in: PROJECT_METHODS
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def show
    authorize @project
    render_params[:include][:project_answers][:include] = :project_question unless render_params[:include].nil? || render_params[:include][:project_answers].nil?
    respond_with_params @project
  end

  api :POST, '/projects', 'Creates projects'
  document_project_params
  param :start_date, String, required: false
  error code: 422, desc: MissingRecordDetection::Messages.not_found

  def create
    authorize Project
    @project = Project.create @project_params
    # Relate user if not an admin
    @project.staff << current_user unless current_user.admin?
    respond_with_params @project
  end

  api :PUT, '/projects/:id', 'Updates project with :id'
  param :id, :number, required: true
  param :includes, Array, in: (PROJECT_FIELDS - ['staff']), required: false
  document_project_params
  error code: 404, desc: MissingRecordDetection::Messages.not_found
  error code: 422, desc: ParameterValidation::Messages.missing

  def update
    authorize @project
    @project.update @project_params
    respond_with_params @project
  end

  api :DELETE, '/projects/:id', 'Deletes project with :id'
  param :id, :number, required: true
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def destroy
    authorize @project
    if @project.destroy
      respond_with @project
    else
      respond_with @project, status: :unprocessable_entity
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
      respond_with @project, status: :unprocessable_entity
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
      respond_with @project, status: :unprocessable_entity
    end
  end

  api :GET, '/projects/:id/approvals', 'Returns a list of all approvals for a project'
  param :id, :number, required: true

  def approvals
    authorize @project
    respond_with @project.approvals
  end

  api :POST, '/projects/:id/approve', 'Set or change the approval for current_user for a project'
  param :id, :number, required: true
  param :includes, Array, required: false, in: (PROJECT_FIELDS - ['staff'])

  def approve
    authorize @project
    Approval.transaction do
      begin
        @approval.approved = true
        @approval.save!
        @project.approval = :approved
        @project.save!
      rescue ActiveRecord::RecordInvalid => ex
        respond_with ex.record
      else
        respond_with_params @project
      end
    end
  end

  api :POST, '/projects/:id/reject', 'Set or change the approval for current_user for a project'
  param :id, :number, required: true
  param :includes, Array, required: false, in: (PROJECT_FIELDS - ['staff'])
  param :reason, String, required: true
  error code: 422, desc: ParameterValidation::Messages.missing

  def reject
    authorize @project
    Approval.transaction do
      begin
        @approval.approved = false
        @approval.reason = params[:reason]
        @approval.save!
        @project.approval = :rejected
        @project.save!
      rescue ActiveRecord::RecordInvalid => ex
        respond_with ex.record
      else
        respond_with_params @project
      end
    end
  end

  private

  def load_project_questions
    @project_questions = ProjectQuestion.all
  end

  def add_empty_answers_to_project(project)
    @project_questions.each do |pq|
      unless project.project_answers.any? { |pa| pa.project_question_id == pq.id }
        project.project_answers << ProjectAnswer.new(project_question: pq)
      end
    end if @project_questions
  end

  def load_projects
    @projects = query_with policy_scope(Project).main_inclusions, :includes, :pagination
  end

  def load_project_params
    @project_params = params.permit(:name, :description, :cc, :budget, :staff_id, :start_date, :end_date, :approved, :img, project_answers: [:project_question_id, :answer, :id])
    @project_params[:project_answers_attributes] = @project_params[:project_answers] unless @project_params[:project_answers].nil?
    @project_params.delete(:project_answers) unless @project_params[:project_answers].nil?
  end

  def load_project
    @project = Project.find(params.require(:id))
    add_empty_answers_to_project @project
  end

  def load_staff
    @staff = Staff.find params.require(:staff_id)
  end

  def load_approval
    @approval = Approval.find_or_initialize_by(project_id: params.require(:id), staff_id: current_user.id)
  end

  def load_rejection_params
    params.require(:reason)
  end
end
