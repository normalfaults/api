class ProvisionFogAzure
  def initialize(order_item)
    @order_item = order_item
    Delayed::Worker.logger.debug 'Initialize Fog Azure'
  end

  def create_storage
    Delayed::Worker.logger.debug 'Begin storage creation'
  end

  def create_vm
    Delayed::Worker.logger.debug 'Begin vm creation'
  end
end
