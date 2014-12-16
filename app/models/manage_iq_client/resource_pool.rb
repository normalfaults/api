module ManageIQClient
  class ResourcePool
    include ManageIQClient::Resource

    self.path = '/api/resource_pools'

    attribute :id, Integer
  end
end
