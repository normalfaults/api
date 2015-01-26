# Description: This MIQ Method will delete a specified EC2 instance
# For use in Service/Provisioning/StateMachines/Methods/RetireEC2

require 'aws-sdk'
require 'net/http'
require 'net/http'
require 'uri/http'
require 'json'

$evm.log("error", "RetireEC2: Enter Method.")

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

# Retrieve the information passed to MIQ from the Dialog call
access_key_id = "#{$evm.root['dialog_access_key_id']}"
secret_access_key = "#{$evm.root['dialog_secret_access_key']}"
instance_id = "#{$evm.root['dialog_instance_id']}"
order_id = "#{$evm.root['dialog_order_item']}"


ec2 = AWS::EC2.new(
    :access_key_id => access_key_id,
    :secret_access_key => secret_access_key
)

# Get the specified VM
begin
  instance = ec2.instances[instance_id]
rescue AWS::EC2::Errors::InvalidClientTokenId => e
  $evm.log("error", "RetireEC2: Invalid Token Id exception caught: #{e.message}")
  send_order_status("CRITICAL", order_id, "","#{e.message}")
  exit
rescue AWS::EC2::Errors => e
  $evm.log("error", "RetireEC2: EC2 exception caught: #{e.message}")
  send_order_status("CRITICAL", order_id, "","#{e.message}")
  exit
end

if instance.exists?
  $evm.log("info", "RetireEC2: Instance exists")
  var = instance.id
  begin
    instance.terminate
    $evm.log("info", "RetireEC2: instance terminated.")
  rescue AWS::EC2::Errors::InvalidClientTokenId => e
    $evm.log("error", "RetireEC2: Invalid client token exception caught: #{e.message}")
    send_order_status("CRITICAL", order_id, "","#{e.message}")
    exit
  rescue AWS::EC2::Errors => e
    $evm.log("error", "RetireEC2: Exception caught #{e.message}")
    send_order_status("CRITICAL",order_id, "","#{e.message}")
    exit
  end
  send_order_status("OK", order_id, "")
else
  $evm.log("error", "RetireEC2: Instance #{instance_id} does not exist.")
  send_order_status("CRITICAL",order_id, "","instance does not exist}")
end

$evm.log("info", "RetireEC2: Instance retired.")

info={
    "order_item" => "#{order_id}"
}
send_order_status("OK", order_id, info, "Instance retired.")
