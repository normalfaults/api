# Created by Jillian Tullo 12/4/2014

# This script provisions a new S3 instance
# Based off of the criteria selected in the marketplace

# For use in MIQ under the
# /Provisioning/StateMachines/Methods/CreateS3

require 'aws-sdk'
#load 'order_status'

$evm.log("info", "Create S3: Entering method")

S3 = AWS::S3.new(
    :access_key_id => "#{$evm.root['dialog_access_key_id']}",
    :secret_access_key => "#{$evm.root['dialog_secret_access_key']}")

bucket_name = "#{$evm.root['dialog_instance_name']}"
order_id = "#{$evm.root['dialog_order_item']}"
$evm.log("info", "Create S3: Bucket name: #{bucket_name}")
begin
  if !S3.buckets[bucket_name].exists?
    S3.buckets.create(bucket_name)
  else
    $evm.log("error", "Create S3: Bucket name already exists.")
    # TODO: send_order_status("CRITICAL", order_id, "","Bucket name already exists.")
    # TODO: Send back the response to the marketplace
    exit
  end
rescue AWS::S3::Errors::InvalidClientTokenId => e
  $evm.log("error", "Create S3: Invalid client token exception caught: #{e.message}.")
  exit
  # TODO: Send back the proper response
rescue AWS::S3::Errors::InvalidParameterValue => e
  $evm.log("error", "Create S3: Invalid parameter exception caught: #{e.message}")
  #TODO: send_order_status("CRITICAL", order_id, "","#{e.message}")
  exit
rescue AWS::S3::Errors => e
  $evm.log("error", "Create S3: AWS Exception caught: #{e.message}")
  #TODO: send_order_status("CRITICAL", order_id, "","#{e.message}")
  exit
rescue Exception => e
  $evm.log("error", "Create S3: General exception caught: #{e.message}")
  $evm.log("error", "Create S3: General exception back trace: #{e.backtrace}")
  #TODO: send_order_status("CRITICAL", order_id, "","#{e.message}")
  exit
end

$evm.log("info", "Create S3: Bucket created.")

# TODO: Send back successful response if the bucket was created

