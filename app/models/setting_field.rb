class SettingField < ActiveRecord::Base
  belongs_to :setting

  store_accessor :options

  enum field_type: [:check_box, :select_option, :text, :date, :password]

  before_save :check_override_setting
  after_find :override_setting

  private

  def check_override_setting
    if !ENV[self.env_var_name].nil? && self.value == ENV[self.env_var_name]
      return false
    end
  end

  def override_setting
    unless self.env_var_name.nil? || ENV[self.env_var_name].nil?
      self.value = ENV[self.env_var_name]
      self.disabled = true
    end
  end
end
