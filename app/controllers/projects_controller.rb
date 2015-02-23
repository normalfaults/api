class ProjectsController < ApplicationController
  PROJECT_FIELDS = %w(alerts approvals approvers latest_alerts project_answers project_detail services staff)
  PROJECT_METHODS = %w(account_number cpu domain hdd icon monthly_spend order_history problem_count ram resources resources_unit state state_ok status url users)
  after_action :verify_authorized

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
    projects = query_with policy_scope(Project).main_inclusions, :includes, :pagination
    authorize_and_normalize(Project.new)
    respond_with_params projects
  end

  api :GET, '/projects/:id', 'Shows project with :id'
  param :id, :number, required: true
  param :includes, Array, required: false, in: PROJECT_FIELDS
  param :methods, Array, required: false, in: PROJECT_METHODS
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def show
    build_empty_answers_to_questions(project)
    authorize_and_normalize(project)
    respond_with_params project
  end

  api :POST, '/projects', 'Creates projects'
  document_project_params
  param :start_date, String, required: false

  def create
    authorize Project
    project = Project.create project_params
    unless current_user.admin?
      project.staff << current_user
    end
    respond_with_params project
  end

  api :PUT, '/projects/:id', 'Updates project with :id'
  param :id, :number, required: true
  param :includes, Array, in: (PROJECT_FIELDS - ['staff']), required: false
  document_project_params
  error code: 404, desc: MissingRecordDetection::Messages.not_found
  error code: 422, desc: ParameterValidation::Messages.missing

  def update
    authorize project
    project.update project_params
    respond_with_params project
  end

  api :DELETE, '/projects/:id', 'Deletes project with :id'
  param :id, :number, required: true
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def destroy
    authorize project
    project.destroy
    respond_with project
  end

  private

  def project_params
    @_project_params ||= params
      .permit(:name, :description, :cc, :budget, :staff_id, :start_date, :end_date, :approved, :img, project_answers: [:project_question_id, :answer, :id])
      .tap do |project|
        if params[:project_answers]
          project[:project_answers_attributes] = project.delete(:project_answers)
        end
      end
  end

  def authorize_and_normalize(project)
    authorize project
    if render_params[:include] && render_params[:include][:project_answers]
      render_params[:include][:project_answers][:include] = :project_question
    end
  end

  def build_empty_answers_to_questions(project)
    ProjectQuestion.all.each do |pq|
      unless project.project_answers.any? { |pa| pa.project_question_id == pq.id }
        project.project_answers << ProjectAnswer.new(project_question: pq)
      end
    end
  end

  def project
    @_project ||= Project.find(params[:id])
  end
end
