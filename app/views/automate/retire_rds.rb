# Created by Jillian Tullo 12/4/2014

# This script deletes an RDS instance
# From an instance collection

require 'aws-sdk'
require 'net/http'
require 'securerandom'
#load 'order_status'

$evm.log("info", "RDSRetire: Enter retirement method.")
rds = AWS::RDS.new(
    :access_key_id => "#{$evm.root['dialog_access_key_id']}",
    :secret_access_key => "#{$evm.root['dialog_secret_access_key']}",
)

# Retrieve information from the dialog
db_instance_id ="#{$evm.root['dialog_instance_name']}"
snapshot_identifier = "#{$evm.root['dialog_snapshot_identifier']}"
final_snapshot = Integer($evm.root['dialog_final_snapshot'])
order_id = "#{$evm.root['dialog_order_item']}"
$evm.log("info", "RDSRetire: snapshot identifier #{snapshot_identifier}")
$evm.log("info", "RDSRetire: final snapshot #{final_snapshot}")
$evm.log("info", "RDSRetire: DB_Instance_ID: #{db_instance_id}")

# Obtain the selected instance from AWS
instance_collection = rds.db_instances
instance = instance_collection[db_instance_id]

#Delete the instance
if instance.exists?
  $evm.log("info", "RDSRetire: Instance exists. Begin retirement.")
  if final_snapshot == 0
    begin
      instance.delete(
          :skip_final_snapshot => true
      )
    rescue AWS::RDS::Errors::InvalidDBInstanceState => e
      $evm.log("error", "RDSRetire: Invalid Instance state: #{e.message}")
      #TODO: send_order_status("CRITICAL", order_id, "","#{e.message}")
      exit
    rescue AWS::RDS::Errors => e
      $evm.log("error", "RDSRetire: Exception caught when deleting instance: #{e.message}")
      exit
    end
  elsif final_snapshot == 1
    begin
      instance.delete(
          :skip_final_snapshot => false,
          :final_db_snapshot_identifier => snapshot_identifier
      )
    rescue AWS::RDS::Errors::DBSnapshotAlreadyExists => e
      $evm.log("error", "RDSRetire: DB Snapshot Already exists exception caught: #{e.message}")
      #TODO: send_order_status("CRITICAL", order_id, "","#{e.message}")
      exit
    rescue AWS::RDS::Errors::InvalidDBInstanceState => e
      $evm.log("error", "RDSRetire: Invalid Instance state: #{e.message}")
      #TODO: send_order_status("CRITICAL", order_id, "","#{e.message}")
      exit
    rescue AWS::RDS::Errors => e
      $evm.log("error", "RDSRetire: Exception caught when deleting instance: #{e.message}")
      #TODO: send_order_status("CRITICAL", order_id, "","#{e.message}")
      exit
    end
  else
    $evm.log("error", "RDSRetire: Must specify final snapshot value.")
    #TODO: send_order_status("CRITICAL", order_id, "","Must specify final snapshot value")
  end
  while instance.status == 'deleting' do
    sleep 5
  end
  $evm.log("info", "RDSRetire: Instance deletion complete. Begin payload response.")
  info = {
      "order_item" => "#{order_id}"
  }
#TODO: send_order_status("OK", order_id, info, "Instance retired."))
else
  $evm.log("error", "RDSRetire: Instance #{db_instance_id} does not exist.")
  #TODO: send_order_status("CRITICAL", order_id, "","Instance does not exist")
end





