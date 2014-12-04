module ManageIQClient
  class Template
    include ManageIQClient::Resource

    self.path = '/api/templates'

    attribute :id, String
    attribute :name, String
    attribute :type, String
    attribute :guid, String
    attribute :vendor, String
    attribute :location, String
    attribute :uid_ems, String
    attribute :power_state, String
    attribute :state_changed_on, String
    attribute :template, Boolean
    attribute :ems_ref, String
    attribute :cloud, Boolean
    attribute :raw_power_state, String
    attribute :publicly_available, Boolean

    attribute :created_on, DateTime
    attribute :updated_on, DateTime
  end
end
