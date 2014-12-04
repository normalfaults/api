module ManageIQClient
  class Datastore
    include ManageIQClient::Resource

    self.path = '/api/datastores'

    attribute :id, Integer
  end
end
