# Created by Jillian Tullo 12/27/2014

# This script un-verifies e-mail addresses
# From an existing SES service

# For use in MIQ under the
# /Provisioning/StateMachines/Methods/CreateSES

require 'aws-sdk'
#load 'order_status'

$evm.log("info", "RetireSES: Entering method")

# Retrieve dialog properties
access_key = "#{$evm.root['dialog_access_key_id']}"
secret_access_key = "#{$evm.root['dialog_secret_access_key']}"
email = "#{$evm.root['dialog_email']}"
order_id = "#{$evm.root['dialog_order_item']}"

AWS.config(
    :access_key_id => access_key,
    :secret_access_key => secret_access_key
)


$evm.log("info", "RetireSES: create service")
ses = AWS::SimpleEmailService.new

# Setup a verified sender if a sender was chosen
if email != ""
  begin
    email_identities = email.split(',')
    email_identities.each do |e|
      $evm.log("info", "RetireSES: E-mail Identity: #{e}")
      ses.identities[e].delete
      $evm.log("info", "RetireSES: Email Identity removed.")
    end
  rescue AWS::SimpleEmailService::Errors::InvalidClientTokenId => e
    $evm.log("error", "RetireSES: Exception caught when creating instance: #{e.message}")
    #TODO: send_order_status("CRITICAL", order_id, "","#{e.message}")
    exit
  rescue AWS::SimpleEmailService::Errors::InvalidParameterValue => e
    $evm.log("error", "RetireSES: Invalid parameter exception caught: #{e.message}")
    #TODO: send_order_status("CRITICAL", order_id, "","#{e.message}")
    exit
  rescue AWS::SimpleEmailService::Errors => e
    $evm.log("error", "RetireSES: Exception caught: #{e.message}")
    #TODO: send_order_status("CRITICAL", order_id, "","#{e.message}")
    exit
  rescue Exception => e
    $evm.log("error", "RetireSES: Exception caught #{e.message}")
    #TODO: send_order_status("CRITICAL", order_id, "","#{e.message}")
    exit
  end
end

info = {
  "order_item" => "#{order_id}"
}
#TODO: send_order_status("OK", order_id, info, "Instance retired.")