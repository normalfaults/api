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

  def current_user
    current_staff || user_from_sso_token
  end

  def user_signed_in?
    staff_signed_in?
  end

  def user_session
    staff_session
  end

  def default_serializer_options
    { root: false }
  end

  private

  def sso_sign_in(user)
    cookies.signed[:sso_token] = {
      email: user.email
    }
    sign_in user
  end

  def user_from_sso_token
    return nil if sso_token.blank?
    user = Staff.find_by(email: sso_token[:email])
    return nil if user.nil?
    user.tap { |u| sign_in u }
  end

  def sso_token
    cookies.signed[:sso_token]
  end
end
