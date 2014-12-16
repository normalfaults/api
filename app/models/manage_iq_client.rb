module ManageIQClient
  mattr_accessor :host
  mattr_accessor :verify_ssl
  mattr_accessor :auth_token

  self.verify_ssl ||= true

  def self.credentials=(credentials)
    ManageIQClient::Base.user = credentials[:user]
    ManageIQClient::Base.password = credentials[:password]
  end
end
