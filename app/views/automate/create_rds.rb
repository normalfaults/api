# Description: This MIQ Method
# provisions a new Amazon RDS Instance from the
# Criteria selected in the marketplace

# For use in MIQ under the
# For use in Service/Provisioning/StateMachines/Methods/CreateRDS

require 'aws-sdk'
require 'net/http'
require 'securerandom'
#load 'order_status'


$evm.log("info", "Entering method /Provisioning/StateMachines/Methods/CreateRDSFromDialog")

rds = AWS::RDS.new(
    :access_key_id => "#{$evm.root['dialog_access_key_id']}",
    :secret_access_key => "#{$evm.root['dialog_secret_access_key']}")

order_id = "#{$evm.root['dialog_order_item']}"
# Create password to pass back to the Marketplace
# AWS RDS instance passwords require a minimum of 8 characters
sec_pw = SecureRandom.hex
sec_pw = sec_pw[0..9] # First 10 characters
$evm.log("info", "CreateRDSFromDialog: Created password #{sec_pw}")

# Set the secure password
$evm.root['root_sec_pw'] = sec_pw

security_groups = $evm.root['dialog_security_groups'] != nil ? $evm.root['dialog_security_groups'] : ""
if security_groups != ""
  security_array = security_groups.split(',')
  security_array.each do |security|
    $evm.log("info", "CreateRDSFromDialog: Security group= #{security}")
  end
end

options = {
    :allocated_storage => Integer($evm.root['dialog_allocated_storage']),
    :db_instance_class => $evm.root['dialog_db_instance_class'],
    :engine => $evm.root['dialog_db_engine'],
    :master_username => $evm.root['dialog_master_username'],
    :master_user_password => sec_pw,
    :storage_type => $evm.root['dialog_storage_type'],
    :vpc_security_group_ids => security_array
}

# Remove all empty strings from the options list
# to avoid error in creation of RDS instance
options.each do |key, value|
  if value == "" || value == nil
    options.delete(key)
  end
end

$evm.log("info", "CreateRDSFromDialog: Set options for new RDS instance: #{options}")

# db_instance_id must be unique to the region.
db_instance_id = "#{$evm.root['dialog_instance_name']}"
$evm.log("info", "CreateRDSFromDialog: Instance Id = #{db_instance_id}")

# Create instance
begin
  instance = rds.db_instances.create(db_instance_id, options)
rescue AWS::RDS::Errors::InvalidClientTokenId => e
  $evm.log("error", "CreateRDSFromDialog: Exception caught when creating instance: #{e.message}")
  $evm.root['instance_failed'] = true
  #TODO: send_order_status("CRITICAL", order_id,  "","#{e.message}")
  exit
rescue AWS::RDS::Errors::DBInstanceAlreadyExists => e
  $evm.log("error", "CreateRDSFromDialog: Instance exists exception: #{e.message}")
  #TODO: send_order_status("CRITICAL", order_id, "","#{e.message}")
  $evm.root['instance_failed'] = true
  exit
rescue AWS::RDS::Errors::InvalidParameterValue => e
  $evm.log("error", "CreateRDSFromDialog: Invalid parameter exception: #{e.message}")
  $evm.root['instance_failed'] = true
  #TODO: send_order_status("CRITICAL", order_id, "","#{e.message}")
  exit
rescue AWS::RDS::Errors::StorageTypeNotSupported => e
  $evm.log("error", "CreateRDSFromDialog: Unsupported storage exception: #{e.message}")
  $evm.root['instance_failed'] = true
  #TODO: send_order_status("CRITICAL", order_id, "","#{e.message}")
  exit
rescue AWS::RDS::Errors => e
  $evm.log("error", "CreateRDSFromDialog: Exception caught when creating instance: #{e.message}")
  $evm.root['instance_failed'] = true
  #TODO: send_order_status("CRITICAL", order_id, "","#{e.message}")
  exit
rescue Exception => e
  $evm.log("error", "CreateRDSFromDialog: General exception caught: #{e.message}")
  $evm.root['instance_failed'] = true
  #TODO: send_order_status("CRITICAL", order_id, "","#{e.message}")
  exit
end

# MIQ heads to next provision step