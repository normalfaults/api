# Display automate code for ManageIQ / CloudForms
class AutomateController < ApplicationController
  layout false
  def catalog_item_initialization
    file      = File.open("app/views/automate/catalog_item_initialization.html.erb", "r")
    contents  = file.read
    file.close
    render plain: contents
  end

  def update_servicemix_and_chef
    file      = File.open("app/views/automate/update_servicemix_and_chef.html.erb", "r")
    contents  = file.read
    file.close
    render plain: contents
  end
end
