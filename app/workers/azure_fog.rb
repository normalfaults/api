class AzureFog
  def initialize(order_item)
    @order_item = order_item
    # Delayed::Worker.logger.debug 'Initialize Fog Azure'
    @azure = Fog::Compute.new(
      provider: '',
      azure_sub_id: '',
      azure_pem: '',
      azure_api_url: ''
    )
  end

  def create_storage
    #  Delayed::Worker.logger.debug 'Begin storage creation'
    @azure.storage_accounts.create(
      name: '',
      location: ''
    )
  end

  def create_server
    #  Delayed::Worker.logger.debug 'Begin vm creation'
    @azure.servers.create(
      image: '',
      location: '',
      vm_name: '',
      vm_user: '',
      password: '',
      storage_account_name: ''
    )
  end

  def azure_servers
    #  Delayed::Worker.logger.debug 'Begin storage creation'
    # TODO: Get server information
    # @azure.servers.each do |server|
    #  puts server.vm_name
    # end
  end
end
