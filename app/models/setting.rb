# == Schema Information
#
# Table name: settings
#
#  id   :integer          not null, primary key
#  name :string(255)
#  hid  :string(255)
#

class Setting < ActiveRecord::Base
  has_many :setting_fields, -> { order('load_order') }
  accepts_nested_attributes_for :setting_fields

  def to_param
    hid
  end

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
