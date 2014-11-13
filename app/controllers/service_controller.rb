class ServiceController < ApplicationController
  # TODO: FIGURE OUT IF PUTTING THIS HERE IS SAFE, CSRF?
  protect_from_forgery

  def show
    json = DummyController.service_json(params[:id].to_s)
    response = {}
    response['verb'] = 'GET'
    response['route'] = ''
    response['status'] = 'OK'
    response['applications'] = json['applications']
    response['header'] = json['header']
    response['projects'] = json['projects']
    response['bundles'] = json['bundles']
    response['marketplaceValues'] = json['marketplace_values']
    response[params[:id].to_s] = json[params[:id].to_s]
    response['solutions'] = json['solutions']
    response['html'] = json['html']
    render json: response.to_json
  end
end
