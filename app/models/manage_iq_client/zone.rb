module ManageIQClient
  class Zone
    include ManageIQClient::Resource

    self.path = '/api/zones'

    attribute :id, Integer
  end
end
