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
  'dialog_instance_name' => 'VM_To_Clone',
  'dialog_datacenter' => 'DC1'
}

$evm = DebugClass.new testHash

require 'rbvmomi'

instance_name = $evm.root['dialog_instance_name']
datacenter = $evm.root['dialog_datacenter']



begin
  $evm.log("info", "DeleteVMWareVM: Begin")
  vim = RbVmomi::VIM.connect host: '173.203.165.9', port: 443, user: 'vsphere.local\administrator', password: 'P@ss1234', debug: true, insecure: true
  $evm.log("info", "DeleteVMWareVM: Port")
  dc = vim.serviceInstance.find_datacenter(datacenter) or fail "Datacenter not found."
  $evm.log("info", "DeleteVMWareVM: Found datacenter")
  vm = dc.find_vm(instance_name) or fail "Could not find VM!"
  $evm.log("info", "DeleteVMWareVM: Found VM")
  vm.Destroy_Task(this: vm)
end
