class OrderItem < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :order
  belongs_to :product
  belongs_to :service

  enum provision_status: [:pending, :active]

  validates :product, presence: true
  validate :validate_product_id

  private

  def validate_product_id
    errors.add(:product, 'Product does not exist.') unless Product.exists?(product_id)
  end
end
