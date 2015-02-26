# Default controller
class ApplicationController < ActionController::Base
  respond_to :json

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

  # Add Token Authentication
  include TokenAuthentication

  protect_from_forgery
  skip_before_action :verify_authenticity_token, if: :json_request?

  def current_user
    current_staff
  end

  def user_signed_in?
    staff_signed_in?
  end

  def user_session
    staff_session
  end

  # Used by ActiveModelSerializers
  def default_serializer_options
    { root: false }
  end

  private

  def json_request?
    request.format.json?
  end
end
