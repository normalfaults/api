class SettingField < ActiveRecord::Base
  belongs_to :setting

  store_accessor :options

  enum field_type: [:check_box, :select_option, :text, :date, :password]

  before_save :check_override_setting?
  after_find :override_setting

  private

  def check_override_setting?
    return false unless env_var_name.nil? || value != ENV[env_var_name]
  end

  def override_setting
    return false if env_var_name.nil? || ENV[env_var_name].nil?
    self.value = ENV[env_var_name]
    self.disabled = true
  end
end
