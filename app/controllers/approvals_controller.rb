class ApprovalsController < ApplicationController
  respond_to :json

  before_action :load_approval, only: [:show, :update, :destroy]
  before_action :load_approval_params, only: [:create, :update]
  before_action :load_approvals, only: [:index]

  after_action :verify_authorized

  api :GET, '/approvals', 'Returns a collection of approvals'
  param :includes, Array, required: false, in: %w(staff project)
  param :page, :number, required: false
  param :per_page, :number, required: false

  def index
    authorize Approval.new
    respond_with_params @approvals
  end

  api :GET, '/approvals/:id', 'Shows approval with :id'
  param :id, :number, required: true
  param :includes, Array, required: false, in: %w(staff project)
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def show
    authorize @approval
    respond_with_params @approval
  end

  api :POST, '/approvals', 'Creates approval'
  param :staff_id, :number, desc: 'Staff'
  param :project_id, :number, desc: 'Project'
  param :approved, :bool, desc: 'Approved?'
  error code: 422, desc: ParameterValidation::Messages.missing

  def create
    @approval = Approval.new @approval_params
    authorize @approval
    if @approval.save
      respond_with @approval
    else
      respond_with @approval, status: :unprocessable_entity
    end
  end

  api :PUT, '/approvals/:id', 'Updates approval with :id'
  param :id, :number, required: true
  param :staff_id, :number, desc: 'Staff'
  param :project_id, :number, desc: 'Project'
  param :approved, :bool, desc: 'Approved?'
  error code: 404, desc: MissingRecordDetection::Messages.not_found
  error code: 422, desc: ParameterValidation::Messages.missing

  def update
    authorize @approval
    if @approval.update_attributes @approval_params
      respond_with @approval
    else
      respond_with @approval, status: :unprocessable_entity
    end
  end

  api :DELETE, '/approvals/:id', 'Deletes approval with :id'
  param :id, :number, required: true
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def destroy
    authorize @approval
    if @approval.destroy
      respond_with @approval
    else
      respond_with @approval, status: :unprocessable_entity
    end
  end

  private

  def load_approval_params
    @approval_params = params.permit(:staff_id, :project_id, :approved)
  end

  def load_approval
    @approval = Approval.find(params.require(:id))
  end

  def load_approvals
    # TODO: Use a FormObject to encapsulate search filters, ordering, pagination
    @approvals = query_with Approval.all, :includes, :pagination
  end
end
