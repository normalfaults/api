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
#  index_settings_on_hid  (hid)
#

class Setting < ActiveRecord::Base
  has_many :setting_fields,  -> { order('load_order') }
  accepts_nested_attributes_for :setting_fields

  def to_param
    hid
  end
end
