class ProvisionWorker
  def initialize(order_item_id)
    @order_item_id = order_item_id
  end

  def perform
    if miq_settings[:enabled]
      miq_provision
    else
      # TODO: Provision according to cloud provider using fog.io
      case order_item.cloud.name
      when 'AWS'
      when 'Azure'
      end
    end
  end

  private

  def order_item
    @order_item ||= OrderItem.find @order_item_id
  end

  def miq_settings
    @miq_settings ||= Setting.find_by(hid: 'manageiq').settings_hash
  end

  def miq_user
    @miq_user ||= Staff.find_by email: miq_settings[:email]
  end

  def miq_provision
    message =
      {
        action: 'order',
        resource: {
          href: "#{miq_settings[:url]}/api/service_templates/#{order_item.product.service_type_id}",
          referer: ENV['DEFAULT_URL'],
          email: miq_user.email,
          token: 'jellyfish-token',
          order_item: {
            id: order_item.id,
            uuid: order_item.uuid.to_s,
            product_details: order_item_details
          }
        }
      }
    order_item.provision_status = :unknown
    order_item.payload_to_miq = message.to_json
    order_item.save

    # TODO: verify_ssl needs to be changed, this is the only way I could get it to work in development.
    resource = RestClient::Resource.new(
      miq_settings[:url],
      user: miq_settings[:username],
      password: miq_settings[:password],
      verify_ssl: OpenSSL::SSL::VERIFY_NONE,
      timeout: 120,
      open_timeout: 60
    )
    handle_response resource, message
  end

  def handle_response(resource, message)
    response = resource["api/service_catalogs/#{order_item.product.service_catalog_id}/service_templates"].post message.to_json, content_type: 'application/json'

    begin
      data = ActiveSupport::JSON.decode(response)
      order_item.payload_reply_from_miq = data.to_json

      case response.code
      when 200..299
        order_item.provision_status = :pending
        order_item.miq_id = data['results'][0]['id']
      when 400..407
        order_item.provision_status = :critical
      else
        order_item.provision_status = :warning
      end

    rescue => e
      message = e.fetch :response, 'Request Timeout'
      error = e.fetch :message, "Action response was out of bounds, or something happened that wasn't expected"
      order_item.provision_status = :unknown
      order_item.payload_reply_from_miq = { error: error, message: message }.to_json

      # Since the exception was caught delayed_jobs wouldn't requeue the job, let's raise an exception
      raise 'error'
    ensure
      order_item.save
    end

    order_item.to_json
  end

  def aws_settings
    @aws_settings ||= Setting.find_by(hid: 'aws').settings_hash
  end

  def order_item_details
    details = {}

    answers = order_item.product.answers
    order_item.product.product_type.questions.each do |question|
      answer = answers.select { |row| row.product_type_question_id == question.id }.first
      details[question.manageiq_key] = answer.nil? ? question.default : answer.answer
    end

    if aws_settings[:enabled]
      details['access_key_id'] = aws_settings[:access_key]
      details['secret_access_key'] = aws_settings[:secret_key]
      details['image_id'] = 'ami-acca47c4'
    end

    details
  end
end
