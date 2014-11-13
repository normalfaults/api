class ProjectController < ApplicationController
  # TODO: FIGURE OUT IF PUTTING THIS HERE IS SAFE, CSRF?
  protect_from_forgery

  def new
    json = DummyController.project_new_json
    response = {}
    response['verb'] = 'GET'
    response['route'] = ''
    response['status'] = 'OK'
    response['applications'] = json['applications']
    response['bundles'] = json['bundles']
    response['projects'] = json['projects']
    response['header'] = json['header']
    response['projectValues'] = json['project_values']
    response['solutions'] = json['solutions']
    response['html'] = json['html']
    render json: response.to_json
  end

  def show
    json = DummyController.project_json(params[:id].to_s)
    response = {}
    response['verb'] = 'GET'
    response['route'] = ''
    response['status'] = 'OK'
    response[params[:id].to_s] = json[params[:id].to_s]
    response['bundles'] = json['bundles']
    response['applications'] = json['applications']
    response['solutions'] = json['solutions']
    response['header'] = json['header']
    response['projects'] = json['projects']
    response['html'] = json['html']
    render json: response.to_json
  end
end
