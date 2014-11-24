module ManageIQClient
  class Policy
    include ManageIQClient::Resource

    self.path = '/api/policies'

    attribute :id, Integer
  end
end
