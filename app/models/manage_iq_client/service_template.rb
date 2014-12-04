module ManageIQClient
  class ServiceTemplate
    include ManageIQClient::Resource

    self.path = '/api/service_templates'

    attribute :id, Integer
  end
end
