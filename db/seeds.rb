require_relative 'seeds/products'
require_relative 'seeds/project_questions'

# AWS Settings
aws_setting = AdminSetting.find_or_create_by(name: 'AWS')

aws_setting.admin_setting_fields.find_or_create_by(label: 'Enabled') do |field|
  field.value = 'false'
  field.field_type = :check_box
  field.load_order = 0
  field.help_text = 'Enable AWS services.'
end

aws_setting.admin_setting_fields.find_or_create_by(label: 'Access Key') do |field|
  field.value =  ''
  field.field_type = :text
  field.load_order = 1
  field.help_text = 'AWS Access Key'
end

aws_setting.admin_setting_fields.find_or_create_by(label: 'Secret Key') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 2
  field.help_text = 'AWS Secret Key'
end

# Manage IQ Settings
miq_setting = AdminSetting.find_or_create_by(name: 'Manage IQ')

miq_setting.admin_setting_fields.find_or_create_by(label: 'URL') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 0
  field.help_text = 'http://example.com'
end

miq_setting.admin_setting_fields.find_or_create_by(label: 'Username') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 1
  field.help_text = 'Username'
end

miq_setting.admin_setting_fields.find_or_create_by(label: 'Password') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 2
  field.help_text = 'Password'
end

# Chef Settings

chef_setting = AdminSetting.find_or_create_by(name: 'Chef')

chef_setting.admin_setting_fields.find_or_create_by(label: 'Enable') do |field|
  field.value = 'false'
  field.field_type = :check_box
  field.load_order = 0
  field.help_text = ''
end

chef_setting.admin_setting_fields.find_or_create_by(label: 'API URL') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 1
  field.help_text = 'http://example.com'
end

chef_setting.admin_setting_fields.find_or_create_by(label: 'Username') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 2
  field.help_text = 'user1'
end

chef_setting.admin_setting_fields.find_or_create_by(label: 'Password') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 3
  field.help_text = 'pass123'
end

# JIRA Settings

jira_setting = AdminSetting.find_or_create_by(name: 'JIRA')

jira_setting.admin_setting_fields.find_or_create_by(label: 'Enable') do |field|
  field.value = 'false'
  field.field_type = :check_box
  field.load_order = 0
  field.help_text = ''
end

jira_setting.admin_setting_fields.find_or_create_by(label: 'API URL') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 1
  field.help_text = 'http://example.com'
end

jira_setting.admin_setting_fields.find_or_create_by(label: 'Username') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 2
  field.help_text = 'user1'
end

jira_setting.admin_setting_fields.find_or_create_by(label: 'Password') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 3
  field.help_text = 'pass123'
end

# Confluence Settings

confluence_setting = AdminSetting.find_or_create_by(name: 'Confluence')

confluence_setting.admin_setting_fields.find_or_create_by(label: 'Enable') do |field|
  field.value = 'false'
  field.field_type = :check_box
  field.load_order = 0
  field.help_text = ''
end

confluence_setting.admin_setting_fields.find_or_create_by(label: 'API URL') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 1
  field.help_text = 'http://example.com'
end

confluence_setting.admin_setting_fields.find_or_create_by(label: 'Username') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 2
  field.help_text = 'user1'
end

confluence_setting.admin_setting_fields.find_or_create_by(label: 'Password') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 3
  field.help_text = 'pass123'
end

# Jenkins

jenkins_setting = AdminSetting.find_or_create_by(name: 'Jenkins')

jenkins_setting.admin_setting_fields.find_or_create_by(label: 'Enable') do |field|
  field.value = 'false'
  field.field_type = :check_box
  field.load_order = 0
  field.help_text = ''
end

jenkins_setting.admin_setting_fields.find_or_create_by(label: 'API URL') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 1
  field.help_text = 'http://example.com'
end

jenkins_setting.admin_setting_fields.find_or_create_by(label: 'API Key') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 2
  field.help_text = 'TOKEN'
end

jenkins_setting.admin_setting_fields.find_or_create_by(label: 'Username') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 3
  field.help_text = 'user1'
end

jenkins_setting.admin_setting_fields.find_or_create_by(label: 'Password') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 4
  field.help_text = 'pass123'
end

# Email

email_setting = AdminSetting.find_or_create_by(name: 'Email')

email_setting.admin_setting_fields.find_or_create_by(label: 'Enable External Server') do |field|
  field.value = 'false'
  field.field_type = :check_box
  field.load_order = 0
  field.help_text = ''
end

email_setting.admin_setting_fields.find_or_create_by(label: 'Server') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 1
  field.help_text = 'smtp.example.com'
end

email_setting.admin_setting_fields.find_or_create_by(label: 'Username') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 2
  field.help_text = 'user1'
end

email_setting.admin_setting_fields.find_or_create_by(label: 'Password') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 3
  field.help_text = 'pass123'
end

email_setting.admin_setting_fields.find_or_create_by(label: 'Send As') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 4
  field.help_text = ''
end

email_setting.admin_setting_fields.find_or_create_by(label: 'Port') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 5
  field.help_text = '25'
end

email_setting.admin_setting_fields.find_or_create_by(label: 'Use SSL') do |field|
  field.value = 'false'
  field.field_type = :check_box
  field.load_order = 6
  field.help_text = ''
end

# LDAP

ldap_setting = AdminSetting.find_or_create_by(name: 'LDAP')

ldap_setting.admin_setting_fields.find_or_create_by(label: 'Enable LDAP') do |field|
  field.value = 'false'
  field.field_type = :check_box
  field.load_order = 0
  field.help_text = ''
end

ldap_setting.admin_setting_fields.find_or_create_by(label: 'Server') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 1
  field.help_text = 'example.com'
end

ldap_setting.admin_setting_fields.find_or_create_by(label: 'Bind DN') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 2
  field.help_text = 'user1'
end

ldap_setting.admin_setting_fields.find_or_create_by(label: 'Bind Password') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 3
  field.help_text = 'pass123'
end

ldap_setting.admin_setting_fields.find_or_create_by(label: 'Base DN') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 4
  field.help_text = ''
end

# Confluence Settings

vmware_setting = AdminSetting.find_or_create_by(name: 'VMware')

vmware_setting.admin_setting_fields.find_or_create_by(label: 'Enable') do |field|
  field.value = 'false'
  field.field_type = :check_box
  field.load_order = 0
  field.help_text = ''
end

vmware_setting.admin_setting_fields.find_or_create_by(label: 'vCenter URL') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 1
  field.help_text = 'http://example.com'
end

vmware_setting.admin_setting_fields.find_or_create_by(label: 'Username') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 2
  field.help_text = 'user1'
end

vmware_setting.admin_setting_fields.find_or_create_by(label: 'Password') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 3
  field.help_text = 'pass123'
end

# Footer Links

footer_setting = AdminSetting.find_or_create_by(name: 'Footer Links')

footer_setting.admin_setting_fields.find_or_create_by(label: 'Link 1 Label') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 0
  field.help_text = 'Example'
end

footer_setting.admin_setting_fields.find_or_create_by(label: 'Link 1 URL') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 0
  field.help_text = 'http://example.com'
end

footer_setting.admin_setting_fields.find_or_create_by(label: 'Link 2 Label') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 1
  field.help_text = 'Example'
end

footer_setting.admin_setting_fields.find_or_create_by(label: 'Link 2 URL') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 1
  field.help_text = 'http://example.com'
end

footer_setting.admin_setting_fields.find_or_create_by(label: 'Link 3 Label') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 2
  field.help_text = 'Example'
end

footer_setting.admin_setting_fields.find_or_create_by(label: 'Link 3 URL') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 2
  field.help_text = 'http://example.com'
end

footer_setting.admin_setting_fields.find_or_create_by(label: 'Link 4 Label') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 3
  field.help_text = 'Example'
end

footer_setting.admin_setting_fields.find_or_create_by(label: 'Link 4 URL') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 3
  field.help_text = 'http://example.com'
end

# Footer Links

header_setting = AdminSetting.find_or_create_by(name: 'Header Links')

header_setting.admin_setting_fields.find_or_create_by(label: 'Link 1 Label') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 0
  field.help_text = 'Example'
end

header_setting.admin_setting_fields.find_or_create_by(label: 'Link 1 URL') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 0
  field.help_text = 'http://example.com'
end

header_setting.admin_setting_fields.find_or_create_by(label: 'Link 2 Label') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 1
  field.help_text = 'Example'
end

header_setting.admin_setting_fields.find_or_create_by(label: 'Link 2 URL') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 1
  field.help_text = 'http://example.com'
end

header_setting.admin_setting_fields.find_or_create_by(label: 'Link 3 Label') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 2
  field.help_text = 'Example'
end

header_setting.admin_setting_fields.find_or_create_by(label: 'Link 3 URL') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 2
  field.help_text = 'http://example.com'
end

header_setting.admin_setting_fields.find_or_create_by(label: 'Link 4 Label') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 3
  field.help_text = 'Example'
end

header_setting.admin_setting_fields.find_or_create_by(label: 'Link 4 URL') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 3
  field.help_text = 'http://example.com'
end
