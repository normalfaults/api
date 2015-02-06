# Default controller
class ApplicationController < ActionController::Base
  respond_to :json, :html

  extend Apipie::DSL::Concern
  include Pundit

  # Error Handling
  include InvalidRecordDetection
  include DuplicateRecordDetection
  include UnauthorizedAccessDetection
  include MissingRecordDetection
  include ParameterValidation

  # Response Rending
  include RenderWithParams
  include MethodResolution

  # Querying
  include Pagination
  include AssociationResolution
  include QueryBuilder

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
