class AddHidsToSettings < ActiveRecord::Migration
  def up
    add_column :settings, :hid, :string, unique: true
    add_column :setting_fields, :hid, :string

    add_index :setting_fields, [:setting_id, :hid], unique: true

    # seeds.rb is being rerun in some environments. Update the settings
    # data so duplication does not happen.
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

  def down
    remove_column :settings, :hid, :string, unique: true
    remove_column :setting_fields, :hid, :string

    remove_index :setting_fields, [:setting_id, :hid]

  end
end
