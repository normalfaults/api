class Provision < ActiveModel::Model
  #attr_accessor :order_id

  #define_model_callbacks :commit

  #belongs_to :order_item
  has_one :order_item

  #validates_presence_of :order_id

  #after_commit :send_provision_request
  #after_touch :send_provision_request

  def initialize
    logger.debug "Initialize"
  end

  #def commit
  #  run_callbacks :commit do
  #    logger.debug "- New Order Item"
  #  end
  #end

  def self.provision
    self.name
  end

  protected

    def send_provision_request
      logger.debug "New Order Item"
    end
end