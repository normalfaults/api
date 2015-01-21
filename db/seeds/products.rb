# Seeds for supported Product Categories

aws_vm = ProductType.create(
  name: 'AWS VM',
  description: 'Amazon EC2 VMs'
)

aws_vm.questions.create(
  label: 'Instance Size',
  field_type: 'select',
  placeholder: '',
  help: '',
  options: [
    ['t2.micro', 't2.micro'],
    ['m3.medium', 'm3.medium'],
    ['m3.large', 'm3.large']
  ],
  default: 'm3.medium',
  required: true,
  load_order: aws_vm.questions.length,
  manageiq_key: 'instance_size'
)

aws_vm.questions.create(
  label: 'Disk Size',
  field_type: 'text',
  placeholder: 'Size in GBs',
  help: '',
  options: nil,
  default: '40',
  required: true,
  load_order: aws_vm.questions.length,
  manageiq_key: 'disk_size'
)

vmware_vm = ProductType.create(
  name: 'VMware VM',
  description: 'VMware VMs'
)

vmware_vm.questions.create(
  label: 'RAM',
  field_type: 'text',
  placeholder: 'Size in GBs',
  help: '',
  options: nil,
  default: '4',
  required: true,
  load_order: vmware_vm.questions.length,
  manageiq_key: 'ram_size'
)

vmware_vm.questions.create(
  label: 'Disk Size',
  field_type: 'text',
  placeholder: 'Size in GBs',
  help: '',
  options: nil,
  default: '40',
  required: true,
  load_order: vmware_vm.questions.length,
  manageiq_key: 'disk_size'
)

vmware_vm.questions.create(
  label: 'CPU',
  field_type: 'select',
  placeholder: '',
  help: '',
  options: [
    ['1', '1 CPU'],
    ['2', '2 CPUs'],
    ['4', '4 CPUs'],
    ['6', '6 CPUs'],
    ['8', '8 CPUs']
  ],
  default: '1',
  required: true,
  load_order: vmware_vm.questions.length,
  manageiq_key: 'cpu_count'
)

rds = ProductType.create(
  name: 'RDS',
  description: 'Description of the RDS product type'
)

rds.questions.create(
  label: 'Instance Size',
  field_type: 'select',
  placeholder: '',
  help: '',
  options: [
    %w(db.m3.medium db.m3.medium),
    %w(db.m3.large db.m3.large),
    %w(db.m3.xlarge db.m3.xlarge)
  ],
  default: 'db.m3.medium',
  required: true,
  load_order: rds.questions.length,
  manageiq_key: 'instance_size'
)

rds.questions.create(
  label: 'DB Engine',
  field_type: 'select',
  placeholder: '',
  help: '',
  options: [
    %w(aurora Aurora),
    %w(mysql MySQL),
    %w(postgresql PostgreSQL),
    ['sqlserver', 'SQL Server']
  ],
  default: '',
  required: true,
  load_order: rds.questions.length,
  manageiq_key: 'db_engine'
)

# rds.questions.create(
#   label: 'Username',
#   field_type: 'text',
#   placeholder: '',
#   help: '',
#   options: nil,
#   default: '',
#   required: true,
#   load_order: rds.questions.length,
#   manageiq_key: 'username'
# )

rds.questions.create(
  label: 'Disk Size',
  field_type: 'text',
  placeholder: 'Size in GBs',
  help: '',
  options: nil,
  default: '40',
  required: true,
  load_order: rds.questions.length,
  manageiq_key: 'disk_size'
)

rds.questions.create(
  label: 'Storage Type',
  field_type: 'select',
  placeholder: '',
  help: '',
  options: [
    %w(magnetic Magnetic),
    %w(ssd SSD),
    %w(iops IOPS)
  ],
  default: 'ssd',
  required: true,
  load_order: rds.questions.length,
  manageiq_key: 'storage_type'
)

s3 = ProductType.create(
  name: 'S3 Bucket',
  description: 'Amazon S3 Buckets'
)

s3.questions.create(
  label: 'Storage Redundancy',
  field_type: 'select',
  placeholder: '',
  help: '',
  options: [
    %w(normal Normal),
    %w(reduced Reduced)
  ],
  default: 'normal',
  required: true,
  load_order: s3.questions.length,
  manageiq_key: 'availability'
)

s3.questions.create(
  label: 'Region',
  field_type: 'select',
  placeholder: '',
  help: '',
  options: [
    ['', 'US Standard'],
    ['us-west-1', 'US-West (Northern California)'],
    ['us-west-2', 'US-West (Oregon)'],
    ['EU', 'EU (Ireland)'],
    ['ap-northeast-1', 'Asia Pacific (Tokyo)'],
    ['ap-southeast-1', 'Asia Pacific (Singapore)'],
    ['ap-southeast-2', 'Asia Pacific (Sydney)']
  ],
  default: '',
  required: true,
  load_order: s3.questions.length,
  manageiq_key: 'region'
)
