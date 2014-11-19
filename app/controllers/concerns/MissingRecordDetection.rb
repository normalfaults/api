module MissingRecordDetection
  module Concern
    extend ActiveSupport::Concern

    NOT_FOUND_MESSAGE = 'Not found.'.freeze

    include do
      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    end

    module ClassMethods
    end

    def record_not_found
      render json: { error: NOT_FOUND_MESSAGE }, status: 404
    end
  end
end
