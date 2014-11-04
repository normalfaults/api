class NotificationsController < ApplicationController
  def index
    @raw_json_string = '[ { "project": { "id": 1, "name": "Company app" }, "description": "2 of your instances (i34648 and i34649) are running but not responding to health checks.", "url": "javascript:" }, { "project": { "id": 2, "name": "Emoticon app" }, "description": "Local file system on volume v23229 (attached to i34649) is at 99% capacity.", "url": "javascript:" } ]'
    @json_response = JSON.parse(@raw_json_string)
    render json: @json_response
  end
end
