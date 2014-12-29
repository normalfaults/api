class HostsController < ProvisionController
  before_action :load_host, only: [:show, :update, :destroy]
  before_action :load_host_params, only: [:create, :update]
  before_action :load_hosts, only: [:index]
end