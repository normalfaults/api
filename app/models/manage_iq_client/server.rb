module ManageIQClient
  class Server
    include ManageIQClient::Resource

    self.path = '/api/servers'

    attribute :id, String
    attribute :name, String
    attribute :guid, String
    attribute :status, String
    attribute :pid, Integer
    attribute :started_on, DateTime
    attribute :build, String
    attribute :percent_memory, Float
    attribute :percent_cpu, Float
    attribute :cpu_time, Float
    attribute :capabilities, Hash
    attribute :last_heartbeat, DateTime
    attribute :os_priority, Integer
    attribute :is_master, Boolean
    attribute :version, String
    attribute :zone_id, String
    attribute :memory_usage, Integer
    attribute :memory_size, Integer
    attribute :hostname, String
    attribute :ipaddress, String
    attribute :drb_uri, String
    attribute :mac_address, String
    attribute :has_active_userinterface, Boolean
    attribute :has_active_webservices, Boolean
    attribute :sql_spid, Integer
    attribute :rhn_mirror, Boolean
  end
end
