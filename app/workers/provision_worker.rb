class ProvisionWorker
  def initialize(order_item_id)
    @order_item_id = order_item_id
  end

  def perform
    order_item = OrderItem.find @order_item_id
    @miq_settings = SettingField.where(setting_id: 2).order(load_order: :asc).as_json
    miq_user = Staff.find(email: 'miq@jellyfish.com').first

    @message =
      {
        action: 'order',
        resource: {
          href: "#{@miq_settings[0]['value']}/api/service_templates/#{order_item.product.service_type_id}",
          referer: ENV['DEFAULT_URL'],
          email: miq_user.email,
          token: miq_user.authentication_token,
          order_id: order_item.id,
          uuid: order_item.uuid.to_s,
          referer: ENV['DEFAULT_URL'],
          product_details: order_item_details(order_item)
        }
      }

    order_item.provision_status = :unknown
    order_item.payload_to_miq = @message.to_json
    order_item.save

    # TODO: verify_ssl needs to be changed, this is the only way I could get it to work in development.
    @resource = RestClient::Resource.new(
      @miq_settings[0]['value'],
      user: @miq_settings[1]['value'],
      password: @miq_settings[2]['value'],
      verify_ssl: OpenSSL::SSL::VERIFY_NONE,
      timeout: 120,
      open_timeout: 60
    )

    handle_response(order_item)
  end

  private

  def handle_response(order_item)
    response = @resource["api/service_catalogs/#{order_item.product.service_catalog_id}/service_templates"].post @message.to_json, content_type: 'application/json'

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

      order_item.save
    rescue => e
      message = e.try(:response) ? e.response : 'Request Timeout'
      error = e.try(:message) ? e.message : 'Action response was out of bounds, or something happened that wasn\'t expected'
      order_item.provision_status = :unknown
      order_item.payload_reply_from_miq = { error: error, message: message }.to_json
      order_item.save

      # Since the exception was caught delayed_jobs wouldn't requeue the job, let's raise an exception
      raise 'error'
    end

    order_item.to_json
  end

  def order_item_details(order_item)
    details = {}

    answers = order_item.product.answers
    order_item.product.product_type.questions.each do |question|
      answer = answers.select { |row| row.product_type_question_id == question.id }.first
      details[question.manageiq_key] = answer.nil? ? question.default : answer.answer
    end

    # TODO: Are we sure that AWS will always be product type 1?
    aws_setting = Setting.where(name: 'AWS').first
    aws_setting_field = SettingField.where(setting_id: aws_setting.id).order(load_order: :asc).as_json

    if aws_setting_field[0]['value'] != 'false'
      details['access_key_id'] = aws_settings[1]['value']
      details['secret_access_key'] = aws_settings[2]['value']
      details['image_id'] = 'ami-acca47c4'
    end

    details
  end
end
