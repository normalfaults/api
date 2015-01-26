# Description: This MIQ Method destroys an S3 instance
# Based off of the criteria selected in the marketplace

# For use in MIQ under the
# For use in Service/Provisioning/StateMachines/Methods/RetireS3

require 'aws-sdk'
require 'net/http'
require 'uri/http'
require 'json'

$evm.log("info", "RetireS3: Enter Method.")

def send_order_status(status, order_id, information, message="")

  host = "jellyfish-core-dev.dpi.bah.com"
  path ="/order_items/#{order_id}/provision_update"
  url = "http://#{host}#{path}"
  uri = URI.parse(url)

  information = information.merge("provision_status" => status.downcase)
  information = information.merge("id" => "#{order_id}")
  $evm.log("info", "send_order_status: Information: #{information}")
  json = {
      "status" => "#{status}",
      "message" => "#{message}",
      "info" => information
  }
  $evm.log("info", "send_order_status: Information #{json.to_json}")
  begin
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Put.new(uri.path)
    request.content_type ="application/json"
    request.body = json.to_json
    response = http.request(request)
    $evm.log("info", "send_order_status: HTTP Response code: #{response.code}")
    $evm.log("info", "send_order_status: HTTP Response message: #{response.message}")
  rescue HTTPExceptions => e
    $evm.log("error", "send_order_status: HTTP Exception caught while sending response back to core: #{e.message}")
  rescue Exception => e
    $evm.log("error", "send_order_status: Exception caught while sending response back to core: #{e.message}")
  end
end # End of function

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
    send_order_status("CRITICAL", order_id, "", "Bucket does not exist and cannot be deleted")
    exit
  end
rescue AWS::S3::Errors::InvalidClientTokenId => e
  $evm.log("error", "RetireS3: Invalid client token exception caught: #{e.message}.")
  send_order_status("CRITICAL", order_id, "","#{e.message}")
  exit
rescue AWS::S3::Errors::InvalidParameterValue => e
  $evm.log("error", "RetireS3: Invalid parameter exception caught: #{e.message}")
  send_order_status("CRITICAL", order_id, "","#{e.message}")
  exit
rescue AWS::S3::Errors => e
  $evm.log("error", "RetireS3: AWS S3 exception caught: #{e.message}")
  send_order_status("CRITICAL", order_id, "","#{e.message}")
  exit
rescue Exception => e
  $evm.log("error", "RetireS3: General exception caught: #{e.message}")
  $evm.log("error", "RetireS3: General exception backtrace: #{e.message}")
  send_order_status("CRITICAL", order_id, "","#{e.message}")
  exit
end

$evm.log("info", "RetireS3: Bucket deleted successfully.")
info = {
    "order_item" => "#{order_id}"
}
send_order_status("OK", order_id, info, "Instance retired.")