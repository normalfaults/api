# # Description: This MIQ Method configures an
# existing Simple Email Service
# It will set the region, as well as set a verified sender
# If a verified sender is chosen

# For use in MIQ under the
# /Provisioning/StateMachines/Methods/CreateSES

require 'aws-sdk'
#load 'order_status'

$evm.log("info", "Create SES: Entering method")

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
    #TODO: send_order_status("CRITICAL", order_id, "","#{e.message}")
    exit
  rescue AWS::RDS::Errors::InvalidParameterValue => e
    $evm.log("error", "CreateSES: Invalid parameter exception caught: #{e.message}")
    #TODO: send_order_status("CRITICAL", order_id, "","#{e.message}")
    exit
  rescue AWS::RDS::Errors => e
    $evm.log("error", "CreateSES: Exception caught: #{e.message}")
    #TODO: send_order_status("CRITICAL", order_id, "","#{e.message}")
    exit
  rescue Exception => e
    $evm.log("error", "CreateSES: Exception caught #{e.message}")
    #TODO: send_order_status("CRITICAL", order_id "","#{e.message}")
    exit
  end
end

# Return the response that it was created successfully
info = {
    "order_item" => "#{order_id}",
    "region" => "#{region}"
}

$evm.log("info", "CreateSES: Provision executed successfully.")
# send_order_status("OK", order_id, info)