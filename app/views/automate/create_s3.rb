# This script provisions a new S3 instance
# Based off of the criteria selected in the marketplace

# For use in MIQ under the
# /Provisioning/StateMachines/Methods/CreateS3

require 'aws-sdk'
load 'order_status.rb'

$evm.log("info", "CreateS3: Entering method")

S3 = AWS::S3.new(
    :access_key_id => "#{$evm.root['dialog_access_key_id']}",
    :secret_access_key => "#{$evm.root['dialog_secret_access_key']}")

bucket_name = "#{$evm.root['dialog_instance_name']}"
order_id = "#{$evm.root['dialog_order_item']}"
$evm.log("info", "CreateS3: Bucket name: #{bucket_name}")

begin
  if !S3.buckets[bucket_name].exists?
    S3.buckets.create(bucket_name)
  else
    $evm.log("error", "CreateS3: Bucket name already exists.")
    send_order_status("CRITICAL", order_id, "", "Bucket already exists.")
    exit
  end
rescue AWS::S3::Errors::InvalidClientTokenId => e
  $evm.log("error", "CreateS3: Invalid client token exception caught: #{e.message}.")
  send_order_status("CRITICAL", order_id, "","#{e.message}")
  exit
rescue AWS::S3::Errors::InvalidParameterValue => e
  $evm.log("error", "CreateS3: Invalid parameter exception caught: #{e.message}")
  send_order_status("CRITICAL", order_id, "","#{e.message}")
  exit
rescue AWS::S3::Errors => e
  $evm.log("error", "Create S3: AWS Exception caught: #{e.message}")
  send_order_status("CRITICAL", order_id, "","#{e.message}")
  exit
rescue Exception => e
  $evm.log("error", "CreateS3: General exception caught: #{e.message}")
  $evm.log("error", "CreateS3: General exception back trace: #{e.backtrace}")
  send_order_status("CRITICAL", order_id, "","#{e.message}")
  exit
end

$evm.log("info", "CreateS3: Bucket created.")
# TODO: Send back successful response if the bucket was created

info = {
    "order_item" => "#{order_id}",
    "bucket_name" => "#{bucket_name}"
}

send_order_status("OK", order_id, info)

