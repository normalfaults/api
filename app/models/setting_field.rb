# == Schema Information
#
# Table name: setting_fields
#
#  id           :integer          not null, primary key
#  label        :string(255)
#  field_type   :integer          default(0)
#  help_text    :string(255)
#  options      :json
#  value        :string(255)
#  required     :string(1)
#  load_order   :integer
#  created_at   :datetime
#  updated_at   :datetime
#  setting_id   :integer
#  env_var_name :string(255)
#  disabled     :boolean          default(FALSE)
#  hid          :string(255)
#
# Indexes
#
#  index_setting_fields_on_setting_id          (setting_id)
#  index_setting_fields_on_setting_id_and_hid  (setting_id,hid) UNIQUE
#

class SettingField < ActiveRecord::Base
  belongs_to :setting

  store_accessor :options

  enum field_type: [:check_box, :select_option, :text, :date, :password]

  before_save :check_override_setting?
#  after_find :override_setting

  private

  def check_override_setting?
    return false unless env_var_name.nil? || value != ENV[env_var_name]
  end

  def override_setting
    return if env_var_name.nil? || ENV[env_var_name].nil?
    self.value = ENV[env_var_name]
    self.disabled = true
  end
end
