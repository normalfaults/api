module ManageIQClient
  class VirtualMachine
    include ManageIQClient::Resource

    self.path = '/api/vms'

    attribute :id, String
    attribute :name, String
    attribute :type, String
    attribute :guid, String
    attribute :vendor, String
    attribute :location, String
    attribute :uid_ems, String
    attribute :power_state, String
    attribute :state_changed_on, String
    attribute :ems_ref, String
    attribute :cloud, Boolean
    attribute :raw_power_state, String
    attribute :flavor_id, Integer
    attribute :availability_zone_id, Integer
    attribute :cloud_network_id, Integer
    attribute :cloud_subnet_id, Integer

    attribute :created_on, DateTime
    attribute :updated_on, DateTime
  end
end
