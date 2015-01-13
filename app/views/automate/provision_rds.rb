# Created by Jillian Tullo 12/11/2014
# Licensed for Booz Allen Hamilton

# Waits for the instance to be out of the creating state
# To retrieve instance properties to pass back to the
# Marketplace

require 'aws-sdk'
require 'rest-client'
require 'rubygems'
#load 'order_status'

$evm.log("info", "ProvisionRDS: Entering /Provisioning/StateMachines/Methods/ProvisionRDS")


# If the instance did not complete creation from the previous state,
# Exit method.
if $evm.root['instance_failed'] == true
  $evm.log("error", "ProvisionRDS:  Could not create instance. Exiting method.")
  exit
end

rds = AWS::RDS.new(
    :access_key_id => "#{$evm.root['dialog_access_key_id']}",
    :secret_access_key => "#{$evm.root['dialog_secret_access_key']}",
)

# Get the instance name of the variable created
db_instance_id ="#{$evm.root['dialog_instance_name']}"
order_id = "#{$evm.root['dialog_order_item']}"
begin
  instance_collection = rds.db_instances
  instance = instance_collection[db_instance_id]
rescue AWS::RDS::Errors::InvalidClientTokenId => e
  $evm.log("error", "ProvisionRDS: Exception caught when creating instance: #{e.message}")
  #TODO: send_order_status("CRITICAL", order_id, "","#{e.message}")
  exit
rescue AWS::RDS::Errors => e
  #TODO: send_order_status("CRITICAL", order_id, "","#{e.message}")
  exit
end

if instance.exists?
  $evm.log("info", "ProvisionRDS: Instance #{db_instance_id} exists")
  # TODO:
  # Wait for the instance to create
  # Instance properties will not be available until the instance has
  # Completed the 'creating' stage
  # Typically takes 2-4 minutes
  while instance.status == 'creating' do
    sleep 5
  end

  #Create the payload to send back to the marketplace
  information ={
      "db_endpoint_address" => "#{instance.endpoint_address}",
      "db_endpoint_port" => "#{instance.endpoint_port}",
      "username" => "#{instance.master_username}",
      "password" => "#{$evm.root['root_sec_pw']}",
      "instance_name" => "#{$evm.root['dialog_instance_name']}",
      "instance_class" => "#{$evm.root['dialog_db_instance_class']}",
      "instance_storage" => "#{$evm.root['dialog_allocated_storage']}"
  }
  $evm.log("info", "ProvisionRDS: Generated the RDS with the following information #{information}")
  #TODO: send_order_status("OK", order_id, information)
else # If the instance did not exist
  $evm.log("info", "ProvisionRDS: Instance #{db_instance_id} was not created and does not exist")
  #TODO: send_order_status("CRITICAL", order_id, "","Instance was not created and does not exist")
end

$evm.log("info", "ProvisionRDS: Instance #{db_instance_id} created")

#
# Description: This method launches the service provisioning job
# This is directly from MIQ

$evm.log("info", "ProvisionRDS: Listing Root Object Attributes:")
$evm.root.attributes.sort.each { |k, v| $evm.log("info", "\t#{k}: #{v}") }
$evm.log("info", "ProvisionRDS: End provisioning")

$evm.root["service_template_provision_task"].execute


