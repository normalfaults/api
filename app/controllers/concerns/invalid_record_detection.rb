module InvalidRecordDetection
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :invalid_record_error
  end

  module ClassMethods
  end

  def invalid_record_error(e)
    render json: { error: e.message }, status: 422
  end
end
