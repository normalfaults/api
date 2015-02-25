# == Schema Information
#
# Table name: settings
#
#  id   :integer          not null, primary key
#  name :string(255)
#  hid  :string(255)
#
# Indexes
#
#  index_settings_on_hid  (hid) UNIQUE
#

class Setting < ActiveRecord::Base
  has_many :setting_fields, -> { order('load_order') }
  accepts_nested_attributes_for :setting_fields, reject_if: :nil_values

  def to_param
    hid
  end

  def nil_values(field)
    field['value_withheld'] && field['value'].nil?
  end

  # Returns a hash of setting_fields with their hids as the key and their value as the value
  # check_box fields are considered booleans and anything but 'true' is false
  def settings_hash
    setting_fields.map do |setting|
      value = case setting.field_type
              when 'check_box'
                'true' == setting.value ? true : false
              else
                setting.value
              end
      [setting.hid.to_sym, value]
    end.to_h
  end
end
