class AddHidsToSettings < ActiveRecord::Migration
  class Setting < ActiveRecord::Base
  end

  class SettingField < ActiveRecord::Base
  end

  def up
    add_column :settings, :hid, :string
    add_column :setting_fields, :hid, :string

    # seeds.rb is being rerun in some environments. Update the settings
    # data so duplication and unique constraint errors do not happen.
    up_settings
    up_setting_fields

    # Do not allow nulls in the hid column
    change_column_null :settings, :hid, false
    change_column_null :setting_fields, :hid, false

    # Index the columns without nulls
    add_index :settings, [:hid], unique: true
    add_index :setting_fields, [:setting_id, :hid], unique: true

    # Reload column definitions; Bypasses an annotate_model issue
    Setting.reset_column_information
    SettingField.reset_column_information
  end

  def down
    remove_column :settings, :hid, :string
    remove_column :setting_fields, :hid, :string

    remove_index :setting_fields, [:setting_id, :hid]
    remove_index :settings, [:hid]
  end

  private

  def up_settings
    Setting.where(name: 'AWS').update_all(hid: 'aws')
    Setting.where(name: 'Manage IQ').update_all(hid: 'manageiq')
    Setting.where(name: 'Chef').update_all(hid: 'chef')
    Setting.where(name: 'JIRA').update_all(hid: 'jira')
    Setting.where(name: 'Confluence').update_all(hid: 'confluence')
    Setting.where(name: 'Jenkins').update_all(hid: 'jenkins')
    Setting.where(name: 'Email').update_all(hid: 'email')
    Setting.where(name: 'LDAP').update_all(hid: 'ldap')
    Setting.where(name: 'VMware').update_all(hid: 'vmware')
    Setting.where(name: 'Footer Links').update_all(hid: 'footer')
    Setting.where(name: 'Header Links').update_all(hid: 'header')
  end

  def up_setting_fields
    SettingField.where(label: ['Enable', 'Enabled', 'Enable External Server', 'Enable LDAP']).update_all(label: 'Enabled', hid: 'enabled')
    SettingField.where(label: ['URL', 'API URL', 'vCenter URL']).update_all(hid: 'url')
    SettingField.where(label: 'Username').update_all(hid: 'username')
    SettingField.where(label: ['Password', 'Bind Password']).update_all(hid: 'password')
    SettingField.where(label: 'Access Key').update_all(hid: 'access_key')
    SettingField.where(label: 'Secret Key').update_all(hid: 'secret_key')
    SettingField.where(label: 'API Key').update_all(hid: 'api_key')
    SettingField.where(label: 'Server').update_all(hid: 'server')
    SettingField.where(label: 'Send As').update_all(hid: 'send_as')
    SettingField.where(label: 'Use SSL').update_all(hid: 'ssl')
    SettingField.where(label: 'Port').update_all(hid: 'port')
    SettingField.where(label: 'Bind DN').update_all(hid: 'bind_dn')
    SettingField.where(label: 'Base DN').update_all(hid: 'base_dn')
    (1..4).each do |n|
      SettingField.where(label: "Link #{n} Label").update_all(hid: "label_#{n}")
      SettingField.where(label: "Link #{n} URL").update_all(hid: "url_#{n}")
    end
  end
end
