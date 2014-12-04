module ManageIQClient
  class Host
    include ManageIQClient::Resource

    self.path = '/api/hosts'

    attribute :id, Integer
  end
end
