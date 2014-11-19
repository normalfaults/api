module ParameterValidation
  module Concern
    extend ActiveSupport::Concern

    MISSING_PARAMETER_MESSAGE = 'Missing parameter'.freeze

    include do
      rescue_from ActionController::ParameterMissing, with: :param_error
      rescue_from Apipie::ParamInvalid, with: :param_error
    end

    module ClassMethods
    end

    def param_error(e)
      render json: { error: e.message }, status: 422
    end
  end
end
