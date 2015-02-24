class ProjectApprovalsController < ApplicationController
  api :GET, '/projects/:project_id/approvals', 'Returns a list of all approvals for a project'
  param :project_id, :number, required: true

  def index
    respond_with project.approvals
  end

  api :POST, '/projects/:id/approve', 'Set or change the approval for current_user for a project'
  param :project_id, :number, required: true
  param :includes, Array, required: false, in: (ProjectsController::PROJECT_INCLUDES - ['staff'])

  def update
    approval = project.approvals.find_or_initialize_by(staff_id: current_user.id)
    perform_in_transaction(project) { approval.approve! }
  end

  api :DELETE, '/projects/:project_id/reject', 'Set or change the approval for current_user for a project'
  param :project_id, :number, required: true
  param :includes, Array, required: false, in: (ProjectsController::PROJECT_INCLUDES - ['staff'])
  param :reason, String, required: true
  error code: 422, desc: ParameterValidation::Messages.missing

  def destroy
    approval = project.approvals.find_or_initialize_by(staff_id: current_user.id)
    perform_in_transaction(project) { approval.reject!(params[:reason]) }
  end

  private

  def perform_in_transaction(project)
    yield
    respond_with_params project
  rescue ActiveRecord::RecordInvalid => ex
    respond_with ex.record
  end

  def project
    @_project ||= Project.find(params[:project_id]).tap { |proj| authorize(proj) }
  end
end
