class OrderItem < ActiveRecord::Base
  # Includes
  acts_as_paranoid

  # Relationships
  belongs_to :order
  belongs_to :product
  belongs_to :cloud
  belongs_to :project
  has_many :alerts, inverse_of: :order_item
  belongs_to :latest_alert, class_name: 'Alert'

  # Hooks
  before_create :inherit_price_data
  after_commit :provision, on: :create

  # Validations
  validates :product, presence: true
  validate :validate_product_id

  # Columns
  enum provision_status: { ok: 0, warning: 1, critical: 2, unknown: 3, pending: 4 }

  private

  def validate_product_id
    errors.add(:product, 'Product does not exist.') unless Product.exists?(product_id)
  end

  def inherit_price_data
    self.hourly_price = product.hourly_price
    self.monthly_price = product.monthly_price
    self.setup_price = product.setup_price
  end

  def provision
    delay(queue: 'provision_request').provision_order_item(id)
  end

  def provision_order_item(order_item_id)
    order_item = OrderItem.find order_item_id
    @miq_settings = SettingField.where(setting_id: 2).order(load_order: :asc).as_json

    @message =
    {
      action: 'order',
      resource: {
        href: "#{@miq_settings[0]['value']}/api/service_templates/#{order_item.product.service_type_id}",
        referrer: ENV['DEFAULT_URL'],
        order_item: {
          order_id: order_item.id,
          uuid: order_item.uuid.to_s,
          referer: ENV['DEFAULT_URL'],
          product_details: order_item_details(order_item)
        }
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
    aws_setting = Setting.find_by_name('AWS').first
    aws_setting_field = SettingField.where(setting_id: aws_setting.id).order(load_order: :asc).as_json

    if aws_setting_field[0]['value'] != 'false'
      details['access_key_id'] = aws_settings[1]['value']
      details['secret_access_key'] = aws_settings[2]['value']
      details['image_id'] = 'ami-acca47c4'
    end

    details
  end
end
