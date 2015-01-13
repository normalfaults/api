# Created by Jillian Tullo on 12/10/2014

# This script will create a new EC2 instance
#  based off of the criteria selected in the marketplace

require 'aws-sdk'
require 'net/http'
#load 'order_status'

# Retrieve the information passed to MIQ from the Dialog call
access_key_id = "#{$evm.root['dialog_access_key_id']}"
secret_access_key = "#{$evm.root['dialog_secret_access_key']}"
image_id = "#{$evm.root['dialog_image_id']}"
instance_type = "#{$evm.root['dialog_instance_type']}"
count = "#{$evm.root['dialog_count']}"
availability_zone = "#{$evm.root['dialog_availability_zone']}"
security_groups = "#{$evm.root['dialog_security_groups']}"
key_name = "#{$evm.root['dialog_key_name']}"
order_id = "#{$evm.root['dialog_order_item']}"
instance_name = "#{$evm.root['dialog_instance_name']}"

# Configure AWS
AWS.config(
    :access_key_id => access_key_id,
    :secret_access_key => secret_access_key
)

# Create the new EC2 instance
ec2 = AWS::EC2.new

# Create the hash of options for the specified VM
options = {
    :image_id => image_id,
    :instance_type => instance_type,
    :count => count,
    :availability_zone => availability_zone,
    :security_groups => security_groups,
    :key_name => key_name
}

# Remove all empty strings from the options list
# to avoid error in creation of EC2 instance
options.each do |key, value|
  if value == "" || value == nil
    options.delete(key)
  end
end

$evm.log("info", "CreateEC2: Options: #{options}")

begin
  instance = ec2.instances.create(options)
rescue AWS::EC2::Errors::InvalidClientTokenId => e
  $evm.log("error", "CreateEC2: Invalid client token exception. Message: #{e.message}")
  #TODO: send_order_status("CRITICAL", order_id, "","#{e.message}")
  exit
rescue AWS::EC2::Errors::InvalidParameterValue => e
  $evm.log("error", "CreateEC2: Invalid parameter exception. Message: #{e.message}")
  #TODO: send_order_status("CRITICAL", order_id, "","#{e.message}")
  exit
rescue Exception => e
  $evm.log("error", "CreateEC2: Could not create instance. Error: #{e}")
  #TODO: send_order_status("CRITICAL", order_id, "","#{e.message}")
  # Should return error message with a response saying it failed
  # Then exit the script
  exit
end

# Amazon needs ~5 seconds before the instance can be accessed
# From the time it is initially created.
sleep 5
if instance.exists?
  while instance.status == :pending
    sleep 5
    #TODO: send_order_status("PENDING", order_id, "")
  end
end

# Return all of the properties inside of a JSON Response
# But first just print them all out

information = {
    "order_item" => "#{order_id}",
    "architecture" => "#{instance.architecture}",
    "dns_name" => "#{instance.dns_name}",
    "id" => "#{instance.id}",
    "image_id" => "#{instance.image_id}",
    "instance_type" => "#{instance.instance_type}",
    "ip_address" =>  "#{instance.ip_address}",
    "key_name" => "#{instance.key_name}",
    "launch_time" => "#{instance.launch_time}",
    "owner_id" => "#{instance.owner_id}",
    "platform" => "#{instance.platform}",
    "private_ip_address" => "#{instance.private_ip_address}",
    "root_device_name" => "#{instance.root_device_name}",
    "root_device_type" => "#{instance.root_device_type}",
    "instance" => "#{instance.status}",
    "subnet_id" => "#{instance.subnet_id}",
    "virtualization_type" => "#{instance.virtualization_type}",
    "vpc_id" => "#{instance.vpc_id}"
}

#TODO: send_order_status("OK", order_id,  information)

$evm.log("info", "CreateEC2: Response =  #{response}")