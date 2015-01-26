# Display automate code for ManageIQ / CloudForms
class AutomateController < ApplicationController
  layout false
  def catalog_item_initialization
    file      = File.open('app/views/automate/catalog_item_initialization.html.erb', 'r')
    contents  = file.read
    file.close
    render plain: contents
  end

  def update_servicemix_and_chef
    file      = File.open('app/views/automate/update_servicemix_and_chef.html.erb', 'r')
    contents  = file.read
    file.close
    render plain: contents
  end

  def create_rds
    file = File.open('app/views/automate/create_rds.html.erb', 'r')
    contents = file.read
    file.close
    render plain: contents
  end

  def provision_rds
    file = File.open('app/views/automate/provision_rds.html.erb', 'r')
    contents = file.read
    file.close
    render plain: contents
  end

  def create_ec2
    file = File.open('app/views/automate/create_ec2.html.erb', 'r')
    contents = file.read
    file.close
    render plain: contents
  end

  def create_s3
    file = File.open('app/views/automate/create_s3.html.erb', 'r')
    contents = file.read
    file.close
    render plain: contents
  end

  def create_ses
    file = File.open('app/views/automate/create_ses.html.erb', 'r')
    contents = file.read
    file.close
    render plain: contents
  end

  def retire_ec2
    file = File.open('app/views/automate/retire_ec2.html.erb', 'r')
    contents = file.read
    file.close
    render plain: contents
  end

  def retire_rds
    file = File.open('app/views/automate/retire_rds.html.erb', 'r')
    contents = file.read
    file.close
    render plain: contents
  end

  def retire_s3
    file = File.open('app/views/automate/retire_s3.html.erb', 'r')
    contents = file.read
    file.close
    render plain: contents
  end

  def retire_ses
    file = File.open('app/views/automate/retire_ses.html.erb', 'r')
    contents = file.read
    file.close
    render plain: contents
  end
end
