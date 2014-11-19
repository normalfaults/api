module ParameterValidation
  module Messages
    class << self
      def missing
        'Missing parameter'.freeze
      end
    end
  end

  extend ActiveSupport::Concern

  included do
    rescue_from ActionController::ParameterMissing, with: :param_error
    rescue_from Apipie::ParamInvalid, with: :param_error
  end

  module ClassMethods
  end

  def param_error(e)
    render json: { error: e.message }, status: 422
  end
end
