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

  acts_as_token_authentication_handler_for Staff

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
