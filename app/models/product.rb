class Product < ActiveRecord::Base
  acts_as_paranoid

  store_accessor :options

  has_many :chargebacks
  belongs_to :cloud
  belongs_to :product_category

  before_save :set_defaults

  private

  def set_defaults
    self.options = [] if self.options.nil?
  end
end
