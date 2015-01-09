# Default controller
class ApplicationController < ActionController::Base
  extend Apipie::DSL::Concern

  include InvalidRecordDetection
  include DuplicateRecordDetection
  include UnauthorizedAccessDetection
  include MissingRecordDetection
  include ParameterValidation
  include RenderWithParams
  include AssociationResolution
  include MethodResolution
  include Pundit

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  def current_user
    current_staff
  end

  def user_signed_in?
    staff_signed_in?
  end

  def user_session
    staff_session
  end
end
