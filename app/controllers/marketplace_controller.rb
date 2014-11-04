class MarketplaceController < ApplicationController
  def index
    @raw_json_string = '{ "searchCategories": [ {"name": "All Categories", "value": 0}, {"name": "Category 1", "value": 1}, {"name": "Category 2", "value": 2} ], "searchCheckboxes": [ {"name": "Third Party", "value": 1}, {"name": "Community", "value": 2}, {"name": "Experimental", "value": 3} ], "projects": [ {"name": "Select Project", "value": 0}, {"name": "Project 1", "value": 1}, {"name": "Project 2", "value": 2} ], "apps": [ {"name": "Select App", "value": 0}, {"name": "App 1", "value": 1}, {"name": "App 2", "value": 2} ], "plans": [ {"name": "Select Plan", "value": 0}, {"name": "Plan 1", "value": 1}, {"name": "Plan 2", "value": 2} ] }'
    @json_response = JSON.parse(@raw_json_string)
    render json: @json_response
  end
end
