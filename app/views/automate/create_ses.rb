# # Description: This MIQ Method configures an
# existing Simple Email Service
# It will set the region, as well as set a verified sender
# If a verified sender is chosen

# For use in MIQ under the
# /Provisioning/StateMachines/Methods/CreateSES

require 'aws-sdk'
require 'net/http'
require 'uri/http'

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

$evm.log("info", "CreateSES: Entering method")

# Retrieve dialog properties
access_key = "#{$evm.root['dialog_access_key_id']}"
secret_access_key = "#{$evm.root['dialog_secret_access_key']}"
region = "#{$evm.root['dialog_region']}"
email = "#{$evm.root['dialog_email']}"
order_id = "#{$evm.root['dialog_order_item']}"

# Setup the SES Region if region was chosen
if region != ""
  AWS.config(
      :access_key_id => access_key,
      :secret_access_key => secret_access_key,
      :ses => { :region => region }
  )
else
  AWS.config(
      :access_key_id => access_key,
      :secret_access_key => secret_access_key
  )
end

$evm.log("info", "CreateSES: create service")
ses = AWS::SimpleEmailService.new

# Setup a verified sender if a sender was chosen
if email != ""
  begin
    email_identities = email.split(',')
    email_identities.each do |e|
      $evm.log("info", "CreateSES: E-mail Identity: #{e}")
      ses.identities.verify(e)
    end
  rescue AWS::SimpleEmailService::Errors::InvalidClientTokenId => e
    $evm.log("error", "CreateSES: Exception caught when creating instance: #{e.message}")
    send_order_status("CRITICAL", order_id, "","#{e.message}")
    exit
  rescue AWS::RDS::Errors::InvalidParameterValue => e
    $evm.log("error", "CreateSES: Invalid parameter exception caught: #{e.message}")
    send_order_status("CRITICAL", order_id, "","#{e.message}")
    exit
  rescue AWS::RDS::Errors => e
    $evm.log("error", "CreateSES: Exception caught: #{e.message}")
    send_order_status("CRITICAL", order_id, "","#{e.message}")
    exit
  rescue Exception => e
    $evm.log("error", "CreateSES: Exception caught #{e.message}")
    send_order_status("CRITICAL", order_id, "","#{e.message}")
    exit
  end
end

# Return the response that it was created successfully
info = {
    "order_item" => "#{order_id}",
    "region" => "#{region}"
}

$evm.log("info", "CreateSES: Provision executed successfully.")
send_order_status("OK", order_id, info)