class StaffController < ApplicationController
  api :GET, '/staff', 'Returns a collection of staff'
  param :query, String, required: false, desc: 'queries against first name, last name, and email'
  param :methods, Array, required: false, in: %w(gravatar allowed)
  param :includes, Array, required: false, in: %w(user_settings projects)
  param :page, :number, required: false
  param :per_page, :number, required: false

  def index
    authorize Staff
    respond_with_params staffs
  end

  api :GET, '/staff/:id', 'Shows staff member with :id'
  param :id, :number, required: true
  param :includes, Array, required: false, in: %w(user_settings projects)
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def show
    respond_with_params staff
  end

  api :GET, '/staff/current_member', 'Shows logged in member'
  param :includes, Array, required: false, in: %w(user_settings projects notifications cart)
  error code: 401, desc: 'User is not signed in.'

  def current_member
    if current_user
      respond_with_params current_user
    else
      render json: { error: 'No session.' }, status: 401
    end
  end

  api :POST, '/staff', 'Creates a staff member'
  param :first_name, String, required: false
  param :last_name, String, required: false
  param :email, String, required: false
  param :role, String, required: false
  param :password, String, required: false
  param :password_confirmation, String, required: false
  error code: 422, desc: MissingRecordDetection::Messages.not_found

  def create
    staff = Staff.new staff_params
    authorize staff
    staff.save
    respond_with staff
  end

  api :PUT, '/staff/:id', 'Updates a staff member with :id'
  param :id, :number, required: true
  param :first_name, String, required: false
  param :last_name, String, required: false
  param :email, String, required: false
  param :role, String, required: false
  param :password, String, required: false
  param :password_confirmation, String, required: false
  error code: 404, desc: MissingRecordDetection::Messages.not_found
  error code: 422, desc: ParameterValidation::Messages.missing

  def update
    staff.update_attributes staff_params
    respond_with staff
  end

  api :DELETE, '/staff/:id', 'Deletes staff member with :id'
  param :id, :number, required: true
  error code: 404, desc: MissingRecordDetection::Messages.not_found

  def destroy
    staff.destroy
    respond_with staff
  end

  private

  def staff
    @staff ||= Staff.find(params.require(:id)).tap { |obj| authorize obj }
  end

  def staffs
    staffs_params = params.permit :query, :includes
    @staffs ||= if staffs_params[:query]
                  Staff.search staffs_params[:query]
                else
                  query_with Staff.all, :includes, :pagination
                end
  end

  def staff_params
    @staff_params = params.permit(:first_name, :last_name, :email, :role, :password, :password_confirmation)
  end
end
