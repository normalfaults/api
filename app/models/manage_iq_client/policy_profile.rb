module ManageIQClient
  class PolicyProfile
    include ManageIQClient::Resource

    self.path = '/api/policy_profiles'

    attribute :id, Integer
  end
end
