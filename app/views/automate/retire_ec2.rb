# Description: This MIQ Method will delete a specified EC2 instance
# For use in Service/Provisioning/StateMachines/Methods/RetireEC2

require 'aws-sdk'
require 'net/http'
#load 'order_status'

$evm.log("error", "RetireEC2: Enter Method.")

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
    #TODO: send_order_status("CRITICAL", order_id, "","#{e.message}")
    exit
rescue AWS::EC2::Errors => e
  $evm.log("error", "RetireEC2: EC2 exception caught: #{e.message}")
  #TODO: send_order_status("CRITICAL", order_id, "","#{e.message}")
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
    #TODO: send_order_status("CRITICAL", order_id, "","#{e.message}")
      exit
  rescue AWS::EC2::Errors => e
    $evm.log("error", "RetireEC2: Exception caught #{e.message}")
    #TODO: send_order_status("CRITICAL",order_id, "","#{e.message}")
    exit
  end
  #TODO: send_order_status("OK", order_id, "")
else
  $evm.log("error", "RetireEC2: Instance #{instance_id} does not exist.")
  #TODO: send_order_status("CRITICAL",order_id, "","instance does not exist}")
  # TODO: Send back response stating that the instance does not exist
end

$evm.log("info", "RetireEC2: Instance retired.")

info={
    "order_item" => "#{order_id}"
}
#TODO: send_order_status("OK", order_id, info, "Instance retired.")
