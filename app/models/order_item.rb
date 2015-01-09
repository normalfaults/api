class OrderItem < ActiveRecord::Base
  acts_as_paranoid

  after_commit :provision, on: :create

  belongs_to :order
  belongs_to :product
  belongs_to :cloud
  belongs_to :project

  #enum provision_status: [:pending, :active, :unknown, :ok]

  validates :product, presence: true
  validate :validate_product_id

  private

  def validate_product_id
    errors.add(:product, 'Product does not exist.') unless Product.exists?(product_id)
  end

  def provision
    # update_attribute causes an endless loop here, so we're going to update the record and save it manually.
    order_item = OrderItem.find(self.id)
    order_item.provision_status = "UNKNOWN"
    order_item.save

    order_item.delay(queue: "provision_request").provision_order_item(order_item)
  end

  def provision_order_item(order_item)
    product = Product.find(order_item.product_id)

    message = { action: "order", order_item: "#{order_item.id}", resource: { href: "#{ENV['MANAGEIQ_HOST']}/api/service_templates/#{product.service_type_id}" } }

    # TODO: verify_ssl needs to be changed, this is the only way I could get it to work in development.
    resource = RestClient::Resource.new(
        "#{ENV['MANAGEIQ_HOST']}",
        user: ENV['MANAGEIQ_USER'],
        password: ENV['MANAGEIQ_PASS'],
        verify_ssl: OpenSSL::SSL::VERIFY_NONE
    )

    response = resource["api/service_catalogs/#{product.service_catalog_id}/service_templates"].post message.to_json, :content_type => 'application/json'

    case response.code
      when 200
        data = ActiveSupport::JSON.decode(response)
        order_item.provision_status = "PENDING"
        order_item.miq_id = data['results'][0]['id']
      else
        order_item.provision_status = "FAILED"
    end

    order_item.save
  end
end
