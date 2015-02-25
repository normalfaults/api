# == Schema Information
#
# Table name: setting_fields
#
#  id           :integer          not null, primary key
#  label        :string(255)
#  field_type   :integer          default(0)
#  help_text    :string(255)
#  options      :json
#  value        :text
#  required     :string(1)
#  load_order   :integer
#  created_at   :datetime
#  updated_at   :datetime
#  setting_id   :integer
#  env_var_name :string(255)
#  disabled     :boolean          default(FALSE)
#  hid          :string(255)
#  secret       :boolean          default(FALSE), not null
#
# Indexes
#
#  index_setting_fields_on_setting_id          (setting_id)
#  index_setting_fields_on_setting_id_and_hid  (setting_id,hid) UNIQUE
#

class SettingField < ActiveRecord::Base
  attr_accessor :value_withheld

  belongs_to :setting

  store_accessor :options

  enum field_type: { check_box: 0, select_option: 1, text: 2, date: 3, password: 4, textarea: 5 }

  after_find :override_setting

  def to_param
    hid
  end

  private

  def override_setting
    return if env_var_name.nil? || ENV[env_var_name].nil?
    self.value = ENV[env_var_name]
    self.disabled = true
  end
end
