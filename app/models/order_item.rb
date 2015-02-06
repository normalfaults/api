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
    ProvisionWorker.new(id).delay(queue: 'provision_request').perform
  end
end
