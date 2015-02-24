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
  belongs_to :setting

  store_accessor :options

  enum field_type: { check_box: 0, select_option: 1, text: 2, date: 3, password: 4, textarea: 5 }

  # before_save :skip_nil_values
  # before_save :environment_setting?
  after_find :override_setting

  def to_param
    hid
  end

  private

  # def skip_nil_values
  #   !value.nil?
  # end
  #
  # def environment_setting?
  #   !(env_var_name.present? && ENV[env_var_name].present?)
  # end

  def override_setting
    return if env_var_name.nil? || ENV[env_var_name].nil?
    self.value = ENV[env_var_name]
    self.disabled = true
  end

  def update_attributes(attributes)
    # Don't save nil values
    attributes.delete(:value) if attributes[:value].presence.nil?

    # Don't save values if we're using the environment
    attributes.delete(:value) if env_var_name.present? && ENV[env_var_name].present?

    super attributes
  end
end
