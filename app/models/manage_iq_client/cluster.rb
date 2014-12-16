module ManageIQClient
  class Cluster
    include ManageIQClient::Resource

    self.path = '/api/clusters'

    attribute :id, Integer
  end
end
