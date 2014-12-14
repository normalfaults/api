module UnauthorizedAccessDetection
  extend ActiveSupport::Concern

  included do
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
    rescue_from Pundit::AuthorizationNotPerformedError, with: :user_not_authorized
  end

  module ClassMethods
  end

  def user_not_authorized
    render json: { error: 'Not authorized.' }, status: 403
  end
end