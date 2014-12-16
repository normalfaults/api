module ManageIQClient
  class Provider
    include ManageIQClient::Resource

    self.path = '/api/providers'

    attribute :id, Integer
  end
end
