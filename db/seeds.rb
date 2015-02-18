# require_relative 'seeds/products'
# require_relative 'seeds/project_questions'
# require_relative 'seeds/staff.rb'

# AWS Settings
aws_setting = Setting.find_or_create_by(name: 'AWS', hid: 'aws')

aws_setting.setting_fields.find_or_create_by(label: 'Enabled', hid: 'enabled') do |field|
  field.value = 'false'
  field.field_type = :check_box
  field.load_order = 0
  field.help_text = 'Enable AWS services.'
  field.env_var_name = 'AWS_ENABLED'
end

aws_setting.setting_fields.find_or_create_by(label: 'Access Key', hid: 'access_key') do |field|
  field.value =  ''
  field.field_type = :text
  field.load_order = 1
  field.help_text = 'AWS Access Key'
  field.env_var_name = 'AWS_ACCESS_KEY'
end

aws_setting.setting_fields.find_or_create_by(label: 'Secret Key', hid: 'secret_key') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 2
  field.help_text = 'AWS Secret Key'
  field.env_var_name = 'AWS_SECRET_KEY'
end

# Manage IQ Settings
miq_setting = Setting.find_or_create_by(name: 'Manage IQ', hid: 'manageiq')

miq_setting.setting_fields.find_or_create_by(label: 'URL', hid: 'url') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 0
  field.help_text = 'http://example.com'
  field.env_var_name = 'MIQ_URL'
end

miq_setting.setting_fields.find_or_create_by(label: 'Username', hid: 'username') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 1
  field.help_text = 'Username'
  field.env_var_name = 'MIQ_USERNAME'
end

miq_setting.setting_fields.find_or_create_by(label: 'Password', hid: 'password') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 2
  field.help_text = 'Password'
  field.env_var_name = 'MIQ_PASSWORD'
end

# Chef Settings

chef_setting = Setting.find_or_create_by(name: 'Chef', hid: 'chef')

chef_setting.setting_fields.find_or_create_by(label: 'Enabled', hid: 'enabled') do |field|
  field.value = 'false'
  field.field_type = :check_box
  field.load_order = 0
  field.help_text = ''
  field.env_var_name = 'CHEF_ENABLED'
end

chef_setting.setting_fields.find_or_create_by(label: 'API URL', hid: 'url') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 1
  field.help_text = 'http://example.com'
  field.env_var_name = 'CHEF_API_URL'
end

chef_setting.setting_fields.find_or_create_by(label: 'Username', hid: 'username') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 2
  field.help_text = 'user1'
  field.env_var_name = 'CHEF_USERNAME'
end

chef_setting.setting_fields.find_or_create_by(label: 'Password', hid: 'password') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 3
  field.help_text = 'pass123'
  field.env_var_name = 'CHEF_PASSWORD'
end

# JIRA Settings

jira_setting = Setting.find_or_create_by(name: 'JIRA', hid: 'jira')

jira_setting.setting_fields.find_or_create_by(label: 'Enabled', hid: 'enabled') do |field|
  field.value = 'false'
  field.field_type = :check_box
  field.load_order = 0
  field.help_text = ''
  field.env_var_name = 'JIRA_ENABLED'
end

jira_setting.setting_fields.find_or_create_by(label: 'API URL', hid: 'url') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 1
  field.help_text = 'http://example.com'
  field.env_var_name = 'JIRA_API_URL'
end

jira_setting.setting_fields.find_or_create_by(label: 'Username', hid: 'username') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 2
  field.help_text = 'user1'
  field.env_var_name = 'JIRA_USERNAME'
end

jira_setting.setting_fields.find_or_create_by(label: 'Password', hid: 'password') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 3
  field.help_text = 'pass123'
  field.env_var_name = 'JIRA_PASSWORD'
end

# Confluence Settings

confluence_setting = Setting.find_or_create_by(name: 'Confluence', hid: 'confluence')

confluence_setting.setting_fields.find_or_create_by(label: 'Enabled', hid: 'enabled') do |field|
  field.value = 'false'
  field.field_type = :check_box
  field.load_order = 0
  field.help_text = ''
  field.env_var_name = 'CONFLUENCE_ENABLED'
end

confluence_setting.setting_fields.find_or_create_by(label: 'API URL', hid: 'url') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 1
  field.help_text = 'http://example.com'
  field.env_var_name = 'CONFLUENCE_API_URL'
end

confluence_setting.setting_fields.find_or_create_by(label: 'Username', hid: 'username') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 2
  field.help_text = 'user1'
  field.env_var_name = 'CONFLUENCE_USERNAME'
end

confluence_setting.setting_fields.find_or_create_by(label: 'Password', hid: 'password') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 3
  field.help_text = 'pass123'
  field.env_var_name = 'CONFLUENCE_PASSWORD'
end

# Jenkins

jenkins_setting = Setting.find_or_create_by(name: 'Jenkins', hid: 'jenkins')

jenkins_setting.setting_fields.find_or_create_by(label: 'Enabled', hid: 'enabled') do |field|
  field.value = 'false'
  field.field_type = :check_box
  field.load_order = 0
  field.help_text = ''
  field.env_var_name = 'JENKINS_ENABLED'
end

jenkins_setting.setting_fields.find_or_create_by(label: 'API URL', hid: 'url') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 1
  field.help_text = 'http://example.com'
  field.env_var_name = 'JENKINS_API_URL'
end

jenkins_setting.setting_fields.find_or_create_by(label: 'API Key', hid: 'api_key') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 2
  field.help_text = 'TOKEN'
  field.env_var_name = 'JENKINS_API_KEY'
end

jenkins_setting.setting_fields.find_or_create_by(label: 'Username', hid: 'username') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 3
  field.help_text = 'user1'
  field.env_var_name = 'JENKINS_USERNAME'
end

jenkins_setting.setting_fields.find_or_create_by(label: 'Password', hid: 'password') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 4
  field.help_text = 'pass123'
  field.env_var_name = 'JENKINS_PASSWORD'
end

# Email

email_setting = Setting.find_or_create_by(name: 'Email', hid: 'email')

email_setting.setting_fields.find_or_create_by(label: 'Enable External Server', hid: 'enabled') do |field|
  field.value = 'false'
  field.field_type = :check_box
  field.load_order = 0
  field.help_text = ''
  field.env_var_name = 'EMAIL_EXT_SERVER_ENABLED'
end

email_setting.setting_fields.find_or_create_by(label: 'Server', hid: 'server') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 1
  field.help_text = 'smtp.example.com'
  field.env_var_name = 'EMAIL_SERVER'
end

email_setting.setting_fields.find_or_create_by(label: 'Username', hid: 'username') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 2
  field.help_text = 'user1'
  field.env_var_name = 'EMAIL_USERNAME'
end

email_setting.setting_fields.find_or_create_by(label: 'Password', hid: 'password') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 3
  field.help_text = 'pass123'
  field.env_var_name = 'EMAIL_PASSWORD'
end

email_setting.setting_fields.find_or_create_by(label: 'Send As', hid: 'send_as') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 4
  field.help_text = ''
  field.env_var_name = 'EMAIL_SEND_AS'
end

email_setting.setting_fields.find_or_create_by(label: 'Port', hid: 'port') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 5
  field.help_text = '25'
  field.env_var_name = 'EMAIL_PORT'
end

email_setting.setting_fields.find_or_create_by(label: 'Use SSL', hid: 'ssl') do |field|
  field.value = 'false'
  field.field_type = :check_box
  field.load_order = 6
  field.help_text = ''
  field.env_var_name = 'EMAIL_USE_SSL'
end

# LDAP

ldap_setting = Setting.find_or_create_by(name: 'LDAP', hid: 'ldap')

ldap_setting.setting_fields.find_or_create_by(label: 'Enable LDAP', hid: 'enabled') do |field|
  field.value = 'false'
  field.field_type = :check_box
  field.load_order = 0
  field.help_text = ''
  field.env_var_name = 'LDAP_ENABLED'
end

ldap_setting.setting_fields.find_or_create_by(label: 'Server', hid: 'server') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 1
  field.help_text = 'example.com'
  field.env_var_name = 'LDAP_SERVER'
end

ldap_setting.setting_fields.find_or_create_by(label: 'Bind DN', hid: 'bind_dn') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 2
  field.help_text = 'user1'
  field.env_var_name = 'LDAP_BIND_DN'
end

ldap_setting.setting_fields.find_or_create_by(label: 'Bind Password', hid: 'bind_password') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 3
  field.help_text = 'pass123'
  field.env_var_name = 'LDAP_BIND_PASSWORD'
end

ldap_setting.setting_fields.find_or_create_by(label: 'Base DN', hid: 'base_dn') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 4
  field.help_text = ''
  field.env_var_name = 'LDAP_BASE_DN'
end

# SAML

saml_setting = Setting.find_or_create_by(name: 'SAML', hid: 'saml')

saml_setting.setting_fields.find_or_create_by(label: 'Enabled', hid: 'enabled') do |f|
  f.value = 'false'
  f.field_type = :check_box
  f.load_order = 0
  f.env_var_name = 'SAML_ENABLED'
end

saml_setting.setting_fields.find_or_create_by(label: 'Issuer', hid: 'issuer') do |f|
  f.value = 'urn:'
  f.field_type = :text
  f.load_order = 1
  f.help_text 'urn:foo.bar.com'
  f.env_var_name = 'SAML_ISSUER'
end

saml_setting.setting_fields.find_or_create_by(label: 'Certificate', hid: 'certificate') do |f|
  f.value = ''
  f.field_type = :textarea
  f.load_order = 2
  f.env_var_name = 'SAML_CERTIFICATE'
end

saml_setting.setting_fields.find_or_create_by(label: 'Cert Fingerprint', hid: 'fingerprint') do |f|
  f.value = ''
  f.field_type = :text
  f.load_order = 3
  f.env_var_name = 'SAML_FINGERPRINT'
end

saml_setting.setting_fields.find_or_create_by(label: 'Enabled', hid: 'enabled') do |f|
  f.value = 'false'
  f.field_type = :check_box
  f.load_order = 0
  f.env_var_name = 'SAML_ENABLED'
end


# VMWare Settings

vmware_setting = Setting.find_or_create_by(name: 'VMware', hid: 'vmware')

vmware_setting.setting_fields.find_or_create_by(label: 'Enabled', hid: 'enabled') do |field|
  field.value = 'false'
  field.field_type = :check_box
  field.load_order = 0
  field.help_text = ''
  field.env_var_name = 'VMWARE_ENABLED'
end

vmware_setting.setting_fields.find_or_create_by(label: 'vCenter URL', hid: 'url') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 1
  field.help_text = 'http://example.com'
  field.env_var_name = 'VMWARE_VCENTER_URL'
end

vmware_setting.setting_fields.find_or_create_by(label: 'Username', hid: 'username') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 2
  field.help_text = 'user1'
  field.env_var_name = 'VMWARE_USERNAME'
end

vmware_setting.setting_fields.find_or_create_by(label: 'Password', hid: 'password') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 3
  field.help_text = 'pass123'
  field.env_var_name = 'VMWARE_PASSWORD'
end

# Footer Links

footer_setting = Setting.find_or_create_by(name: 'Footer Links', hid: 'footer')

footer_setting.setting_fields.find_or_create_by(label: 'Link 1 Label', hid: 'label_1') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 0
  field.help_text = 'Example'
  field.env_var_name = 'FOOTER_LINK_1_LABEL'
end

footer_setting.setting_fields.find_or_create_by(label: 'Link 1 URL', hid: 'url_1') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 0
  field.help_text = 'http://example.com'
  field.env_var_name = 'FOOTER_LINK_1_URL'
end

footer_setting.setting_fields.find_or_create_by(label: 'Link 2 Label', hid: 'label_2') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 1
  field.help_text = 'Example'
  field.env_var_name = 'FOOTER_LINK_2_LABEL'
end

footer_setting.setting_fields.find_or_create_by(label: 'Link 2 URL', hid: 'url_2') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 1
  field.help_text = 'http://example.com'
  field.env_var_name = 'FOOTER_LINK_2_URL'
end

footer_setting.setting_fields.find_or_create_by(label: 'Link 3 Label', hid: 'label_3') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 2
  field.help_text = 'Example'
  field.env_var_name = 'FOOTER_LINK_3_LABEL'
end

footer_setting.setting_fields.find_or_create_by(label: 'Link 3 URL', hid: 'url_3') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 2
  field.help_text = 'http://example.com'
  field.env_var_name = 'FOOTER_LINK_3_URL'
end

footer_setting.setting_fields.find_or_create_by(label: 'Link 4 Label', hid: 'label_4') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 3
  field.help_text = 'Example'
  field.env_var_name = 'FOOTER_LINK_4_LABEL'
end

footer_setting.setting_fields.find_or_create_by(label: 'Link 4 URL', hid: 'url_4') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 3
  field.help_text = 'http://example.com'
  field.env_var_name = 'FOOTER_LINK_4_URL'
end

# Header Links

header_setting = Setting.find_or_create_by(name: 'Header Links', hid: 'header')

header_setting.setting_fields.find_or_create_by(label: 'Link 1 Label', hid: 'label_1') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 0
  field.help_text = 'Example'
  field.env_var_name = 'HEADER_LINK_1_LABEL'
end

header_setting.setting_fields.find_or_create_by(label: 'Link 1 URL', hid: 'url_1') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 0
  field.help_text = 'http://example.com'
  field.env_var_name = 'HEADER_LINK_1_URL'
end

header_setting.setting_fields.find_or_create_by(label: 'Link 2 Label', hid: 'label_2') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 1
  field.help_text = 'Example'
  field.env_var_name = 'HEADER_LINK_2_LABEL'
end

header_setting.setting_fields.find_or_create_by(label: 'Link 2 URL', hid: 'url_2') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 1
  field.help_text = 'http://example.com'
  field.env_var_name = 'HEADER_LINK_2_URL'
end

header_setting.setting_fields.find_or_create_by(label: 'Link 3 Label', hid: 'label_3') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 2
  field.help_text = 'Example'
  field.env_var_name = 'HEADER_LINK_3_LABEL'
end

header_setting.setting_fields.find_or_create_by(label: 'Link 3 URL', hid: 'url_3') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 2
  field.help_text = 'http://example.com'
  field.env_var_name = 'HEADER_LINK_3_URL'
end

header_setting.setting_fields.find_or_create_by(label: 'Link 4 Label', hid: 'label_4') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 3
  field.help_text = 'Example'
  field.env_var_name = 'HEADER_LINK_4_LABEL'
end

header_setting.setting_fields.find_or_create_by(label: 'Link 4 URL', hid: 'url_4') do |field|
  field.value = ''
  field.field_type = :text
  field.load_order = 3
  field.help_text = 'http://example.com'
  field.env_var_name = 'HEADER_LINK_4_URL'
end
