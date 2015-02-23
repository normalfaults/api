class ProjectStaffController < ApplicationController
  api :GET, '/projects/:project_id/staff', 'Shows collection of staff for a :project_id'
  param :project_id, :number, required: true
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def index
    project = Project.find(params[:project_id])
    authorize project
    respond_with project.staff
  end

  api :POST, '/projects/:project_id/staff/:id', 'Adds staff to a project'
  param :id, :number, desc: 'Staff', required: true
  param :project_id, :number, required: true
  error code: 404, desc: MissingRecordDetection::Messages.not_found
  error code: 422, desc: MissingRecordDetection::Messages.not_found

  def create
    project = Project.find(params[:project_id])
    staff = Staff.find(params[:id])
    authorize project
    project.staff << staff
    respond_with @staff = staff
  end

  api :DELETE, '/projects/:project_id/staff/:id', 'Deletes staff from a project'
  param :id, :number, required: true
  param :project_id, :number, required: true
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def destroy
    project = Project.find(params[:project_id])
    staff = Staff.find(params[:id])
    authorize project
    if project.staff.delete staff
      respond_with staff
    else
      respond_with project, status: :unprocessable_entity
    end
  end
end
