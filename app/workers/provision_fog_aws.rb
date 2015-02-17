class ProvisionFogAws
  def initialize(order_item)
    @order_item = order_item
    Delayed::Worker.logger.debug 'Initialize Fog AWS'
  end

  def create_rds
    Delayed::Worker.logger.debug 'Begin RDS Creation'
  end

  def create_ec2
    Delayed::Worker.logger.debug 'Begin EC2 Creation'
  end
end
