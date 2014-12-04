module ManageIQClient
  class ServiceCatalog
    include ManageIQClient::Resource

    self.path = '/api/service_catalogs'

    attribute :id, Integer
  end
end
