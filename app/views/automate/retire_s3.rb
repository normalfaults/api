# Created by Jillian Tullo 12/4/2014

# This script destroys an S3 instance
# Based off of the criteria selected in the marketplace

# For use in MIQ under the
# For use in Service/Provisioning/StateMachines/Methods/RetireS3

require 'aws-sdk'
require 'net/http'
#load 'order_status'


$evm.log("info", "RetireS3: Enter Method.")

S3 = AWS::S3.new(
    :access_key_id => "#{$evm.root['dialog_access_key_id']}",
    :secret_access_key => "#{$evm.root['dialog_secret_access_key']}")

bucket_name = "#{$evm.root['dialog_instance_name']}"
order_id = "#{$evm.root['dialog_order_item']}"
$evm.log("info", "RetireS3: Bucket name: #{bucket_name}")
begin
  bucket = S3.buckets[bucket_name]
  if bucket.exists?
    bucket.delete
  else
    $evm.log("error", "Retire S3: Bucket does not exist. ")
    # TODO: Send back response. 
    exit
  end
rescue AWS::S3::Errors::InvalidClientTokenId => e
  $evm.log("error", "RetireS3: Invalid client token exception caught: #{e.message}.")
  #TODO: send_order_status("CRITICAL", order_id, "","#{e.message}")
  exit
rescue AWS::S3::Errors::InvalidParameterValue => e
  $evm.log("error", "RetireS3: Invalid parameter exception caught: #{e.message}")
  #TODO: send_order_status("CRITICAL", order_id, "","#{e.message}")
  exit
rescue AWS::S3::Errors => e
  $evm.log("error", "RetireS3: AWS S3 exception caught: #{e.message}")
  #TODO: send_order_status("CRITICAL", order_id, "","#{e.message}")
  exit
rescue Exception => e
  $evm.log("error", "RetireS3: General exception caught: #{e.message}")
  $evm.log("error", "RetireS3: General exception backtrace: #{e.message}")
  #TODO: send_order_status("CRITICAL", order_id, "","#{e.message}")
  exit
end

$evm.log("info", "RetireS3: Bucket deleted successfully.")
info = {
    "order_item" => "#{order_id}"
}
#TODO: send_order_status("OK", order_id, info, "Instance retired.")