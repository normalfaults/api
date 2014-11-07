class MarketplaceController < ApplicationController
  # TODO: FIGURE OUT IF PUTTING THIS HERE IS SAFE WRT CSRF?
  protect_from_forgery

  def index   # display all items
    @raw_json_string = '{ "verb" : "GET", "action" : "", "status" : "OK", "searchCategories": [ {"name": "All Categories", "value": 0}, {"name": "Category 1", "value": 1}, {"name": "Category 2", "value": 2} ], "searchCheckboxes": [ {"name": "Third Party", "value": 1}, {"name": "Community", "value": 2}, {"name": "Experimental", "value": 3} ], "projects": [ {"name": "Select Project", "value": 0}, {"name": "Project 1", "value": 1}, {"name": "Project 2", "value": 2} ], "apps": [ {"name": "Select App", "value": 0}, {"name": "App 1", "value": 1}, {"name": "App 2", "value": 2} ], "plans": [ {"name": "Select Plan", "value": 0}, {"name": "Plan 1", "value": 1}, {"name": "Plan 2", "value": 2} ] }'
    @json_response = JSON.parse(@raw_json_string)
    render json: @json_response
  end

  def new     # get html form to create new item
    @raw_json_string = '{ "verb" : "GET", "action" : "new", "status" : "OK", "form_elements" : { "form_element1" : "value1", "form_element2" : "value2", "form_element3" : "value3" } }'
    @json_response = JSON.parse(@raw_json_string)
    render json: @json_response
  end

  def create  # create a new item from populated html form]
    # Rails checks POST for CSRF session_auth (protect_from_forgery at top sets null auth_session)
    @raw_json_string = '{ "verb" : "POST", "action" : "create", "status" : "OK" }'
    @json_response = JSON.parse(@raw_json_string)
    render json: @json_response
  end

  def show    # display specified item
    @raw_json_string = '{ "verb" : "GET", "action" : "show", "status" : "OK" }'
    @json_response = JSON.parse(@raw_json_string)
    render json: @json_response
  end

  def edit    # get html form to edit specified item
    @raw_json_string = '{ "verb" : "GET", "action" : "edit", "id" : "' + params[:id] + '", "status" : "OK", "form_elements" : { "form_element1" : "value1", "form_element2" : "value2", "form_element3" : "value3" } }'
    @json_response = JSON.parse(@raw_json_string)
    render json: @json_response
  end

  def update  # updates a specified item with html form elements
    # Rails checks POST for CSRF session_auth (protect_from_forgery at top sets null auth_session)
    @raw_json_string = '{ "verb" : "PUT/POST", "action" : "update", "id" : "' + params[:id] + '", "status" : "OK" }'
    @json_response = JSON.parse(@raw_json_string)
    render json: @json_response
  end

  def destroy  # deletes a specified item
    @raw_json_string = '{ "verb" : "DELETE", "action" : "destroy", "id" : "' + params[:id] + '", "status" : "OK" }'
    @json_response = JSON.parse(@raw_json_string)
    render json: @json_response
  end
end
