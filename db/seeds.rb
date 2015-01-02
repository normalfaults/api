# AWS Settings
aws_setting = AdminSetting.find_or_create_by(name: 'AWS')

aws_setting.admin_setting_fields.find_or_create_by(label: 'Enabled') do |field|
  field.value = 'false'
  field.field_type = :check_box
  field.load_order = 0
  field.help_text = 'Enable AWS services.'
  field.options = []
end

aws_setting.admin_setting_fields.find_or_create_by(label: 'Access Key') do |field|
  field.value =  ''
  field.field_type = :text
  field.load_order = 1
  field.help_text = 'AWS Access Key'
  field.options = []
end

aws_setting.admin_setting_fields.find_or_create_by(label: 'Secret Key') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 2
  field.help_text = 'AWS Secret Key'
  field.options = []
end

# Manage IQ Settings
miq_setting = AdminSetting.find_or_create_by(name: 'Manage IQ')

miq_setting.admin_setting_fields.find_or_create_by(label: 'URL') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 0
  field.help_text = 'http://example.com'
  field.options = []
end

miq_setting.admin_setting_fields.find_or_create_by(label: 'Username') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 1
  field.help_text = 'Username'
  field.options = []
end

miq_setting.admin_setting_fields.find_or_create_by(label: 'Password') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 2
  field.help_text = 'Password'
  field.options = []
end

# Chef Settings

chef_setting = AdminSetting.find_or_create_by(name: 'Chef')

chef_setting.admin_setting_fields.find_or_create_by(label: 'Enable') do |field|
  field.value = 'false'
  field.field_type = :check_box
  field.load_order = 0
  field.help_text = ''
  field.options = []
end

chef_setting.admin_setting_fields.find_or_create_by(label: 'API URL') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 1
  field.help_text = 'http://example.com'
  field.options = []
end

chef_setting.admin_setting_fields.find_or_create_by(label: 'Username') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 2
  field.help_text = 'user1'
  field.options = []
end

chef_setting.admin_setting_fields.find_or_create_by(label: 'Password') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 3
  field.help_text = 'pass123'
  field.options = []
end

# JIRA Settings

jira_setting = AdminSetting.find_or_create_by(name: 'JIRA')

jira_setting.admin_setting_fields.find_or_create_by(label: 'Enable') do |field|
  field.value = 'false'
  field.field_type = :check_box
  field.load_order = 0
  field.help_text = ''
  field.options = []
end

jira_setting.admin_setting_fields.find_or_create_by(label: 'API URL') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 1
  field.help_text = 'http://example.com'
  field.options = []
end

jira_setting.admin_setting_fields.find_or_create_by(label: 'Username') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 2
  field.help_text = 'user1'
  field.options = []
end

jira_setting.admin_setting_fields.find_or_create_by(label: 'Password') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 3
  field.help_text = 'pass123'
  field.options = []
end

# Confluence Settings

confluence_setting = AdminSetting.find_or_create_by(name: 'Confluence')

confluence_setting.admin_setting_fields.find_or_create_by(label: 'Enable') do |field|
  field.value = 'false'
  field.field_type = :check_box
  field.load_order = 0
  field.help_text = ''
  field.options = []
end

confluence_setting.admin_setting_fields.find_or_create_by(label: 'API URL') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 1
  field.help_text = 'http://example.com'
  field.options = []
end

confluence_setting.admin_setting_fields.find_or_create_by(label: 'Username') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 2
  field.help_text = 'user1'
  field.options = []
end

confluence_setting.admin_setting_fields.find_or_create_by(label: 'Password') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 3
  field.help_text = 'pass123'
  field.options = []
end

# Jenkins

jenkins_setting = AdminSetting.find_or_create_by(name: 'Jenkins')

jenkins_setting.admin_setting_fields.find_or_create_by(label: 'Enable') do |field|
  field.value = 'false'
  field.field_type = :check_box
  field.load_order = 0
  field.help_text = ''
  field.options = []
end

jenkins_setting.admin_setting_fields.find_or_create_by(label: 'API URL') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 1
  field.help_text = 'http://example.com'
  field.options = []
end

jenkins_setting.admin_setting_fields.find_or_create_by(label: 'API Key') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 2
  field.help_text = 'TOKEN'
  field.options = []
end

jenkins_setting.admin_setting_fields.find_or_create_by(label: 'Username') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 3
  field.help_text = 'user1'
  field.options = []
end

jenkins_setting.admin_setting_fields.find_or_create_by(label: 'Password') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 4
  field.help_text = 'pass123'
  field.options = []
end

# Email

email_setting = AdminSetting.find_or_create_by(name: 'Email')

email_setting.admin_setting_fields.find_or_create_by(label: 'Enable External Server') do |field|
  field.value = 'false'
  field.field_type = :check_box
  field.load_order = 0
  field.help_text = ''
  field.options = []
end

email_setting.admin_setting_fields.find_or_create_by(label: 'Server') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 1
  field.help_text = 'smtp.example.com'
  field.options = []
end

email_setting.admin_setting_fields.find_or_create_by(label: 'Username') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 2
  field.help_text = 'user1'
  field.options = []
end

email_setting.admin_setting_fields.find_or_create_by(label: 'Password') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 3
  field.help_text = 'pass123'
  field.options = []
end

email_setting.admin_setting_fields.find_or_create_by(label: 'Send As') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 4
  field.help_text = ''
  field.options = []
end

email_setting.admin_setting_fields.find_or_create_by(label: 'Port') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 5
  field.help_text = '25'
  field.options = []
end

email_setting.admin_setting_fields.find_or_create_by(label: 'Use SSL') do |field|
  field.value = 'false'
  field.field_type = :check_box
  field.load_order = 6
  field.help_text = ''
  field.options = []
end

# LDAP

ldap_setting = AdminSetting.find_or_create_by(name: 'LDAP')

ldap_setting.admin_setting_fields.find_or_create_by(label: 'Enable LDAP') do |field|
  field.value = 'false'
  field.field_type = :check_box
  field.load_order = 0
  field.help_text = ''
  field.options = []
end

ldap_setting.admin_setting_fields.find_or_create_by(label: 'Server') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 1
  field.help_text = 'example.com'
  field.options = []
end

ldap_setting.admin_setting_fields.find_or_create_by(label: 'Bind DN') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 2
  field.help_text = 'user1'
  field.options = []
end

ldap_setting.admin_setting_fields.find_or_create_by(label: 'Bind Password') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 3
  field.help_text = 'pass123'
  field.options = []
end

ldap_setting.admin_setting_fields.find_or_create_by(label: 'Base DN') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 4
  field.help_text = ''
  field.options = []
end

# Confluence Settings

vmware_setting = AdminSetting.find_or_create_by(name: 'VMware')

vmware_setting.admin_setting_fields.find_or_create_by(label: 'Enable') do |field|
  field.value = 'false'
  field.field_type = :check_box
  field.load_order = 0
  field.help_text = ''
  field.options = []
end

vmware_setting.admin_setting_fields.find_or_create_by(label: 'vCenter URL') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 1
  field.help_text = 'http://example.com'
  field.options = []
end

vmware_setting.admin_setting_fields.find_or_create_by(label: 'Username') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 2
  field.help_text = 'user1'
  field.options = []
end

vmware_setting.admin_setting_fields.find_or_create_by(label: 'Password') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 3
  field.help_text = 'pass123'
  field.options = []
end
