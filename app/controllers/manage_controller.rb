class ManageController < ApplicationController
  # TODO: FIGURE OUT IF PUTTING THIS HERE IS SAFE, CSRF?
  protect_from_forgery

  def index   # display all items
    json = DummyController.manage_json
    response = {}
    response['verb'] = 'GET'
    response['route'] = ''
    response['status'] = 'OK'
    response['solutions'] = json['solutions']
    response['projects'] = json['projects']
    response['applications'] = json['applications']
    response['bundles'] = json['bundles']
    response['header'] = json['header']
    response['manageValues'] = json['manage_values']
    response['recentOrders'] = json['recent_orders']
    response['recentUsers'] = json['recent_users']
    response['alerts'] = json['alerts']
    response['html'] = json['html']
    render json: response.to_json
  end
end
