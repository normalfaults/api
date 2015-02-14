# require_relative 'seeds/products'
# require_relative 'seeds/project_questions'
# require_relative 'seeds/staff.rb'

# AWS Settings
aws_setting = Setting.find_or_create_by(name: 'AWS')

aws_setting.setting_fields.find_or_create_by(label: 'Enabled') do |field|
  field.value = 'false'
  field.field_type = :check_box
  field.load_order = 0
  field.help_text = 'Enable AWS services.'
  field.env_var_name = 'AWS_ENABLED'
end

aws_setting.setting_fields.find_or_create_by(label: 'Access Key') do |field|
  field.value =  ''
  field.field_type = :text
  field.load_order = 1
  field.help_text = 'AWS Access Key'
  field.env_var_name = 'AWS_ACCESS_KEY'
end

aws_setting.setting_fields.find_or_create_by(label: 'Secret Key') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 2
  field.help_text = 'AWS Secret Key'
  field.env_var_name = 'AWS_SECRET_KEY'
end

# Manage IQ Settings
miq_setting = Setting.find_or_create_by(name: 'Manage IQ')

miq_setting.setting_fields.find_or_create_by(label: 'URL') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 0
  field.help_text = 'http://example.com'
  field.env_var_name = 'MIQ_URL'
end

miq_setting.setting_fields.find_or_create_by(label: 'Username') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 1
  field.help_text = 'Username'
  field.env_var_name = 'MIQ_USERNAME'
end

miq_setting.setting_fields.find_or_create_by(label: 'Password') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 2
  field.help_text = 'Password'
  field.env_var_name = 'MIQ_PASSWORD'
end

# Chef Settings

chef_setting = Setting.find_or_create_by(name: 'Chef')

chef_setting.setting_fields.find_or_create_by(label: 'Enable') do |field|
  field.value = 'false'
  field.field_type = :check_box
  field.load_order = 0
  field.help_text = ''
  field.env_var_name = 'CHEF_ENABLED'
end

chef_setting.setting_fields.find_or_create_by(label: 'API URL') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 1
  field.help_text = 'http://example.com'
  field.env_var_name = 'CHEF_API_URL'
end

chef_setting.setting_fields.find_or_create_by(label: 'Username') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 2
  field.help_text = 'user1'
  field.env_var_name = 'CHEF_USERNAME'
end

chef_setting.setting_fields.find_or_create_by(label: 'Password') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 3
  field.help_text = 'pass123'
  field.env_var_name = 'CHEF_PASSWORD'
end

# JIRA Settings

jira_setting = Setting.find_or_create_by(name: 'JIRA')

jira_setting.setting_fields.find_or_create_by(label: 'Enable') do |field|
  field.value = 'false'
  field.field_type = :check_box
  field.load_order = 0
  field.help_text = ''
  field.env_var_name = 'JIRA_ENABLED'
end

jira_setting.setting_fields.find_or_create_by(label: 'API URL') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 1
  field.help_text = 'http://example.com'
  field.env_var_name = 'JIRA_API_URL'
end

jira_setting.setting_fields.find_or_create_by(label: 'Username') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 2
  field.help_text = 'user1'
  field.env_var_name = 'JIRA_USERNAME'
end

jira_setting.setting_fields.find_or_create_by(label: 'Password') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 3
  field.help_text = 'pass123'
  field.env_var_name = 'JIRA_PASSWORD'
end

# Confluence Settings

confluence_setting = Setting.find_or_create_by(name: 'Confluence')

confluence_setting.setting_fields.find_or_create_by(label: 'Enable') do |field|
  field.value = 'false'
  field.field_type = :check_box
  field.load_order = 0
  field.help_text = ''
  field.env_var_name = 'CONFLUENCE_ENABLED'
end

confluence_setting.setting_fields.find_or_create_by(label: 'API URL') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 1
  field.help_text = 'http://example.com'
  field.env_var_name = 'CONFLUENCE_API_URL'
end

confluence_setting.setting_fields.find_or_create_by(label: 'Username') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 2
  field.help_text = 'user1'
  field.env_var_name = 'CONFLUENCE_USERNAME'
end

confluence_setting.setting_fields.find_or_create_by(label: 'Password') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 3
  field.help_text = 'pass123'
  field.env_var_name = 'CONFLUENCE_PASSWORD'
end

# Jenkins

jenkins_setting = Setting.find_or_create_by(name: 'Jenkins')

jenkins_setting.setting_fields.find_or_create_by(label: 'Enable') do |field|
  field.value = 'false'
  field.field_type = :check_box
  field.load_order = 0
  field.help_text = ''
  field.env_var_name = 'JENKINS_ENABLED'
end

jenkins_setting.setting_fields.find_or_create_by(label: 'API URL') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 1
  field.help_text = 'http://example.com'
  field.env_var_name = 'JENKINS_API_URL'
end

jenkins_setting.setting_fields.find_or_create_by(label: 'API Key') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 2
  field.help_text = 'TOKEN'
  field.env_var_name = 'JENKINS_API_KEY'
end

jenkins_setting.setting_fields.find_or_create_by(label: 'Username') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 3
  field.help_text = 'user1'
  field.env_var_name = 'JENKINS_USERNAME'
end

jenkins_setting.setting_fields.find_or_create_by(label: 'Password') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 4
  field.help_text = 'pass123'
  field.env_var_name = 'JENKINS_PASSWORD'
end

# Email

email_setting = Setting.find_or_create_by(name: 'Email')

email_setting.setting_fields.find_or_create_by(label: 'Enable External Server') do |field|
  field.value = 'false'
  field.field_type = :check_box
  field.load_order = 0
  field.help_text = ''
  field.env_var_name = 'EMAIL_EXT_SERVER_ENABLED'
end

email_setting.setting_fields.find_or_create_by(label: 'Server') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 1
  field.help_text = 'smtp.example.com'
  field.env_var_name = 'EMAIL_SERVER'
end

email_setting.setting_fields.find_or_create_by(label: 'Username') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 2
  field.help_text = 'user1'
  field.env_var_name = 'EMAIL_USERNAME'
end

email_setting.setting_fields.find_or_create_by(label: 'Password') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 3
  field.help_text = 'pass123'
  field.env_var_name = 'EMAIL_PASSWORD'
end

email_setting.setting_fields.find_or_create_by(label: 'Send As') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 4
  field.help_text = ''
  field.env_var_name = 'EMAIL_SEND_AS'
end

email_setting.setting_fields.find_or_create_by(label: 'Port') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 5
  field.help_text = '25'
  field.env_var_name = 'EMAIL_PORT'
end

email_setting.setting_fields.find_or_create_by(label: 'Use SSL') do |field|
  field.value = 'false'
  field.field_type = :check_box
  field.load_order = 6
  field.help_text = ''
  field.env_var_name = 'EMAIL_USE_SSL'
end

# LDAP

ldap_setting = Setting.find_or_create_by(name: 'LDAP')

ldap_setting.setting_fields.find_or_create_by(label: 'Enable LDAP') do |field|
  field.value = 'false'
  field.field_type = :check_box
  field.load_order = 0
  field.help_text = ''
  field.env_var_name = 'LDAP_ENABLED'
end

ldap_setting.setting_fields.find_or_create_by(label: 'Server') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 1
  field.help_text = 'example.com'
  field.env_var_name = 'LDAP_SERVER'
end

ldap_setting.setting_fields.find_or_create_by(label: 'Bind DN') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 2
  field.help_text = 'user1'
  field.env_var_name = 'LDAP_BIND_DN'
end

ldap_setting.setting_fields.find_or_create_by(label: 'Bind Password') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 3
  field.help_text = 'pass123'
  field.env_var_name = 'LDAP_BIND_PASSWORD'
end

ldap_setting.setting_fields.find_or_create_by(label: 'Base DN') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 4
  field.help_text = ''
  field.env_var_name = 'LDAP_BASE_DN'
end

# VMWare Settings

vmware_setting = Setting.find_or_create_by(name: 'VMware')

vmware_setting.setting_fields.find_or_create_by(label: 'Enable') do |field|
  field.value = 'false'
  field.field_type = :check_box
  field.load_order = 0
  field.help_text = ''
  field.env_var_name = 'VMWARE_ENABLED'
end

vmware_setting.setting_fields.find_or_create_by(label: 'vCenter URL') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 1
  field.help_text = 'http://example.com'
  field.env_var_name = 'VMWARE_VCENTER_URL'
end

vmware_setting.setting_fields.find_or_create_by(label: 'Username') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 2
  field.help_text = 'user1'
  field.env_var_name = 'VMWARE_USERNAME'
end

vmware_setting.setting_fields.find_or_create_by(label: 'Password') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 3
  field.help_text = 'pass123'
  field.env_var_name = 'VMWARE_PASSWORD'
end

# Footer Links

footer_setting = Setting.find_or_create_by(name: 'Footer Links')

footer_setting.setting_fields.find_or_create_by(label: 'Link 1 Label') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 0
  field.help_text = 'Example'
  field.env_var_name = 'FOOTER_LINK_1_LABEL'
end

footer_setting.setting_fields.find_or_create_by(label: 'Link 1 URL') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 0
  field.help_text = 'http://example.com'
  field.env_var_name = 'FOOTER_LINK_1_URL'
end

footer_setting.setting_fields.find_or_create_by(label: 'Link 2 Label') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 1
  field.help_text = 'Example'
  field.env_var_name = 'FOOTER_LINK_2_LABEL'
end

footer_setting.setting_fields.find_or_create_by(label: 'Link 2 URL') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 1
  field.help_text = 'http://example.com'
  field.env_var_name = 'FOOTER_LINK_2_URL'
end

footer_setting.setting_fields.find_or_create_by(label: 'Link 3 Label') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 2
  field.help_text = 'Example'
  field.env_var_name = 'FOOTER_LINK_3_LABEL'
end

footer_setting.setting_fields.find_or_create_by(label: 'Link 3 URL') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 2
  field.help_text = 'http://example.com'
  field.env_var_name = 'FOOTER_LINK_3_URL'
end

footer_setting.setting_fields.find_or_create_by(label: 'Link 4 Label') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 3
  field.help_text = 'Example'
  field.env_var_name = 'FOOTER_LINK_4_LABEL'
end

footer_setting.setting_fields.find_or_create_by(label: 'Link 4 URL') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 3
  field.help_text = 'http://example.com'
  field.env_var_name = 'FOOTER_LINK_4_URL'
end

# Header Links

header_setting = Setting.find_or_create_by(name: 'Header Links')

header_setting.setting_fields.find_or_create_by(label: 'Link 1 Label') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 0
  field.help_text = 'Example'
  field.env_var_name = 'HEADER_LINK_1_LABEL'
end

header_setting.setting_fields.find_or_create_by(label: 'Link 1 URL') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 0
  field.help_text = 'http://example.com'
  field.env_var_name = 'HEADER_LINK_1_URL'
end

header_setting.setting_fields.find_or_create_by(label: 'Link 2 Label') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 1
  field.help_text = 'Example'
  field.env_var_name = 'HEADER_LINK_2_LABEL'
end

header_setting.setting_fields.find_or_create_by(label: 'Link 2 URL') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 1
  field.help_text = 'http://example.com'
  field.env_var_name = 'HEADER_LINK_2_URL'
end

header_setting.setting_fields.find_or_create_by(label: 'Link 3 Label') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 2
  field.help_text = 'Example'
  field.env_var_name = 'HEADER_LINK_3_LABEL'
end

header_setting.setting_fields.find_or_create_by(label: 'Link 3 URL') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 2
  field.help_text = 'http://example.com'
  field.env_var_name = 'HEADER_LINK_3_URL'
end

header_setting.setting_fields.find_or_create_by(label: 'Link 4 Label') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 3
  field.help_text = 'Example'
  field.env_var_name = 'HEADER_LINK_4_LABEL'
end

header_setting.setting_fields.find_or_create_by(label: 'Link 4 URL') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 3
  field.help_text = 'http://example.com'
  field.env_var_name = 'HEADER_LINK_4_URL'
end
