class OrderItem < ActiveRecord::Base
  acts_as_paranoid

  before_create :load_order_item_params

  after_commit :provision, on: :create

  belongs_to :order
  belongs_to :product
  belongs_to :cloud
  belongs_to :project

  enum provision_status: [ok: 0, warning: 1, critical: 2, unknown: 3, pending: 4]

  validates :product, presence: true
  validate :validate_product_id

  private

  def validate_product_id
    errors.add(:product, 'Product does not exist.') unless Product.exists?(product_id)
  end

  def load_order_item_params
    self.hourly_price = product.hourly_price
    self.monthly_price = product.monthly_price
    self.setup_price = product.setup_price
  end

  def provision
    # Calling save inside an after_commit on: :create triggers a :create callback again.
    # Passed the object to the provision_order_item and called the save there.
    # https://github.com/rails/rails/issues/14493#issuecomment-39859373
    order_item = self

    order_item.delay(queue: 'provision_request').provision_order_item(order_item)
  end

  def provision_order_item(order_item)
    order_item.provision_status = :unknown
    order_item.save

    message = { action: 'order', order_item: "#{order_item.id}", resource: { href: "#{ENV['MANAGEIQ_HOST']}/api/service_templates/#{order_item.product.service_type_id}" } }

    # TODO: verify_ssl needs to be changed, this is the only way I could get it to work in development.
    resource = RestClient::Resource.new(
        "#{ENV['MANAGEIQ_HOST']}",
        user: ENV['MANAGEIQ_USER'],
        password: ENV['MANAGEIQ_PASS'],
        verify_ssl: OpenSSL::SSL::VERIFY_NONE
    )

    response = resource["api/service_catalogs/#{order_item.product.service_catalog_id}/service_templates"].post message.to_json, content_type: 'application/json'

    case response.code
    when 200
      data = ActiveSupport::JSON.decode(response)
      order_item.provision_status = :pending
      order_item.miq_id = data['results'][0]['id']
    else
      order_item.provision_status = :warning
    end

    order_item.save
  end
end
