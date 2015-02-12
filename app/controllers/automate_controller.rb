# Display automate code for ManageIQ / CloudForms
class AutomateController < ApplicationController
  layout false
  def catalog_item_initialization
    render 'automate/catalog_item_initialization.html.erb', content_type: :plain
  end

  def update_servicemix_and_chef
    render 'automate/update_servicemix_and_chef.html.erb', content_type: :plain
  end

  def create_rds
    render 'automate/create_rds.html.erb', content_type: :plain
  end

  def provision_rds
    render 'automate/provision_rds.html.erb', content_type: :plain
  end

  def create_ec2
    render 'automate/create_ec2.html.erb', content_type: :plain
  end

  def create_s3
    render 'automate/create_s3.html.erb', content_type: :plain
  end

  def create_ses
    render 'automate/create_ses.html.erb', content_type: :plain
  end

  def retire_ec2
    render 'automate/retire_ec2.html.erb', content_type: :plain
  end

  def retire_rds
    render 'automate/retire_rds.html.erb', content_type: :plain
  end

  def retire_s3
    render 'automate/retire_s3.html.erb', content_type: :plain
  end

  def retire_ses
    render 'automate/retire_ses.html.erb', content_type: :plain
  end

  def create_vmware_vm
    render 'automate/create_vmware_vm.html.erb', content_type: :plain
  end

  def retire_vmware_vm
    render 'automate/retire_vmware_vm.html.erb', content_type: :plain
  end

  def create_chef_node
    render 'automate/create_chef_node.html.erb', content_type: :plain
  end
end
