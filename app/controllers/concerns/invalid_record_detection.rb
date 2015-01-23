module InvalidRecordDetection
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :invalid_record_error
  end

  module ClassMethods
  end

  def invalid_record_error(e)
    # Display the error in the development log
    Rails.logger.warn(e.message) if 'development' == Rails.env
    render json: { error: e.message }, status: 422
  end
end
