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
  'dialog_instance_name' => 'Automate_Test_2',
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
  cloneVM = dc.find_vm('Template-2')
  dc = vim.serviceInstance.find_datacenter('DC1')
  configuration = RbVmomi::VIM.VirtualMachineConfigSpec(:annotation => 'Creation time:  ' + Time.now.strftime("%Y-%m-%d %H:%M") + "\n\n")
  hosts = dc.hostFolder.children
  pool = hosts.first.resourcePool
  relocation_spec = RbVmomi::VIM.VirtualMachineRelocateSpec(pool: pool)
  custom_spec = vim.serviceContent.customizationSpecManager.GetCustomizationSpec(:name => 'rhel-dhcp').spec
  clone_spec =  RbVmomi::VIM.VirtualMachineCloneSpec(
    location: relocation_spec,
    config: configuration,
    customization: custom_spec,
    powerOn: true,
    template: false
  )
  task = cloneVM.CloneVM_Task(:folder => cloneVM.parent, :name => 'Automation-Test-2', :spec => clone_spec)
  task.wait_for_completion
rescue StandardError => e
  $evm.log("error", "CloneVM: General exception caught: #{e.message}")
end