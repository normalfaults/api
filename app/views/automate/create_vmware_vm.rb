#Debug class used to create a test $evm.root instance
class DebugClass
  attr_accessor :root
  def initialize root
    @root = root
  end

  def log(level, message)
    puts "LOG MESSAGE LEVEL #{level}: #{message}"
  end
end

testHash = {
  'dialog_instance_name' => 'Cloned_VM',
  'dialog_num_CPUs' => 1,
  'dialog_memory_mb' => 4,
  'dialog_datastore_path' => '[datastore2]',
  'dialog_datacenter' => 'DC1',
  'dialog_ip_address'  => ''
}

$evm = DebugClass.new testHash

# This script provisions a VMWare VM and
# assigns it an IP address

require 'rbvmomi'

# Retrieve all information set from the marketplace
instance_name = $evm.root['dialog_instance_name']
num_CPUs = Integer($evm.root['dialog_num_CPUs'])
memory_mb = Integer($evm.root['dialog_memory_mb'])
datastore_path = $evm.root['dialog_datastore_path']
datacenter = $evm.root['dialog_datacenter']
ip_address = $evm.root['dialog_ip_address']

begin
  $evm.log("info", "CreateVMWareVM: Begin")
  vim = RbVmomi::VIM.connect host: '173.203.165.9', port: 443, user: 'vsphere.local\administrator', password: 'P@ss1234', debug: true, insecure: true
  dc = vim.serviceInstance.find_datacenter(datacenter) or fail "Datacenter not found."
  $evm.log("info", "CreateVMWareVM: Found datacenter #{datacenter}")
  configuration = {
    name: instance_name,
    numCPUs: num_CPUs,
    memoryMB: memory_mb,
    files: { vmPathName: datastore_path },
    deviceChange: [
      {
        operation: :add,
        device: RbVmomi::VIM.VirtualE1000(
          key: 0,
          deviceInfo: {
            label: 'Network Adapter 1',
              summary: 'VM Network'
          },
          backing: RbVmomi::VIM.VirtualEthernetCardNetworkBackingInfo(
          deviceName: 'VM Network'
          ),
          addressType: 'generated'
        )
      }
    ]
  }
  cust_ip_settings = RbVmomi::VIM::CustomizationIPSettings.new
  cust_ip_settings.ip = RbVmomi::VIM::CustomizationFixedIp("ipAddress" => "10.0.0.1")
  cust_adapter_mapping = [RbVmomi::VIM::CustomizationAdapterMapping.new("adapter" => cust_ip_settings)]
  cust_prep = RbVmomi::VIM::CustomizationLinuxPrep.new(
    domain: 'fake-test-this-can-fail',
    hostName: 'fake-test-this-can-fail',
    hwClockUTC: true,
    timeZone: 'US/Eastern')
  cust_global_ip_settings = RbVmomi::VIM::CustomizationGlobalIPSettings.new
  custom_spec = RbVmomi::VIM::CustomizationSpec.new(
    identity: cust_prep,
    nicSettingMap: cust_adapter_mapping,
    globalIPSettings: cust_global_ip_settings
  )
  cloneVM = dc.find_vm('VM_To_Clone')
  pool = cloneVM.resourcePool
  relocation_spec = RbVmomi::VIM.VirtualMachineRelocateSpec(pool: pool)
  clone_spec =  RbVmomi::VIM.VirtualMachineCloneSpec(
    location: relocation_spec,
    config: configuration,
    customization: custom_spec,
    powerOn: true,
    template: false
  )
  task = cloneVM.CloneVM_Task(:folder => cloneVM.parent, :name => 'Please-work', :spec => clone_spec)
  $evm.log("error", "CloneVM: GOT EM!!!!!!!!")
  task.wait_for_completion
rescue StandardError => e
  $evm.log("error", "CloneVM: General exception caught: #{e.message}")
end