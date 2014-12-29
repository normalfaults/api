module ManageIQClient
  module Resource
    def self.included(base)
      base.include Virtus.model
      base.extend ClassMethods
      base.cattr_accessor :path
      base.send(:attr_accessor, :errors)
      base.send(:attr_accessor, :id)
    end

    module ClassMethods
      def list(params = {})
        client.find collection_path, params
        #client
      end

      def find(id, params = {})
        new(client.find resource_path(id), params)
      end

      def client
        @client ||= ManageIQClient::Base.new
      end

      def collection_path
        path
      end

      def resource_path(id)
        "#{path}/#{id}"
      end
    end

    def initialize
      @errors = []
    end

    def _id
      id.split(path + '/')[-1].to_i
    rescue
      id
    end

    # TODO: ManageIQ uses a non RESTful message format
    # def save
    #   res = client.save self
    #   self.id = ActiveSupport::JSON.decode(res)[resource_name]['id'] unless res.blank?
    #   true
    # rescue RestClient::UnprocessableEntity => e
    #   self.errors = ActiveSupport::JSON.decode(e.response)
    #   false
    # end

    def client
      self.class.client
    end

    def to_payload
      attributes
      # { resource_name => attributes }
    end

    def destroy
      client.destroy self
    end

    def resource_name
      self.class.to_s.demodulize.underscore
    end

    def to_json
      { resource_name => attributes }.to_json
    end

    def path
      [self.class.path, id].join '/'
    end
  end
end
