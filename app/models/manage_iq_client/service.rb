module ManageIQClient
  class Service
    include ManageIQClient::Resource

    self.path = '/api/services'

    attribute :id, Integer
  end
end
