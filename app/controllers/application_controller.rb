# Default controller
class ApplicationController < ActionController::Base
  extend Apipie::DSL::Concern

  include Pagination
  include InvalidRecordDetection
  include DuplicateRecordDetection
  include UnauthorizedAccessDetection
  include MissingRecordDetection
  include ParameterValidation
  include RenderWithParams
  include MethodResolution
  include Pundit

  include Pagination
  include AssociationResolution
  include QueryBuilder

  # protect_from_forgery

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
