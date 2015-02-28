class StaffProjectsController < ApplicationController
  api :GET, '/staff/:staff_id/project', 'Shows collection of projects for a staff :staff_id'
  param :staff_id, :number, required: true
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def index
    authorize staff, :projects?
    respond_with staff.projects
  end

  api :PUT, '/staff/:id/projects/:id', 'Adds project to a staff member'
  param :staff_id, :number, required: true
  param :id, :number, required: true, desc: 'Project'
  error code: 422, desc: MissingRecordDetection::Messages.not_found

  def update
    authorize staff, :add_project?
    if staff.projects << project
      respond_with project
    else
      respond_with staff, status: :unprocessable_entity
    end
  end

  api :DELETE, '/staff/:id/project/:id', 'Deletes project from a staff'
  param :staff_id, :number, required: true
  param :id, :number, required: true, desc: 'Project'
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def destroy
    authorize staff, :remove_project?
    if staff.projects.delete project
      respond_with project
    else
      respond_with staff, status: :unprocessable_entity
    end
  end

  private

  def staff
    @staff ||= Staff.find(params.require(:staff_id))
  end

  def project
    @project ||= Project.find(params.require(:id))
  end
end
