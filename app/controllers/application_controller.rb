# Default controller
class ApplicationController < ActionController::Base
  extend Apipie::DSL::Concern
  include MissingRecordDetection
  include ParameterValidation
  include AssociationResolution
  include Pundit

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def current_user
    current_staff
  end

  def user_signed_in?
    staff_signed_in?
  end

  def user_session
    staff_session
  end

  private

  def user_not_authorized
    # TODO: Change to a more RESTful response
    flash[:error] = 'You are not authorized to perform this action.'
    redirect_to(request.referrer || root_path)
  end
end
