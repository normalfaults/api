module ManageIQClient
  class Base
    DEFAULT_HEADERS = { accept: :json, content_type: :json }
    attr_accessor :client
    cattr_accessor :user, :password

    delegate :[], to: :client

    def initialize
      setup_args = [ManageIQClient.host]
      setup_hash = { verify_ssl: ManageIQClient.verify_ssl }
      setup_hash.merge! user: self.class.user, password: self.class.password unless ManageIQClient.auth_token
      setup_args += [setup_hash]
      @client = RestClient::Resource.new(*setup_args)
    end

    def headers
      headers = DEFAULT_HEADERS
      headers.merge! 'X-Auth-Token' => ManageIQClient.auth_token if ManageIQClient.auth_token
      headers
    end

    def save(resource)
      path = resource.class.collection_path
      payload = resource.to_payload
      payload.merge! files: resource.files if resource.respond_to?(:files) && resource.files
      send_payload path, 'add', payload
    end

    def update(resource)
      path = resource.resource_pathh
      payload = resource.to_payload
      payload.merge! files: resource.files if resource.respond_to?(:files) && resource.files
      send_payload path, 'edit', payload
    end

    def destroy(resource)
      client[resource.path].delete headers
    end

    def find(path, params = {})
      ActiveSupport::JSON.decode(client[path_and_params path, params].get headers)
    end

    def path_and_params(path, params)
      params.nil? ? path : [path, params.to_param].join('?')
    end

    private

    def send_payload(path, action, payload)
      msg = { action: action, resource: payload }
      case action
      when 'add', 'create', 'edit'
        client[path].post msg, headers
      end
    end
  end
end
