# == Schema Information
#
# Table name: settings
#
#  id   :integer          not null, primary key
#  name :string(255)
#  hid  :string(255)
#

class Setting < ActiveRecord::Base
  has_many :setting_fields,  -> { order('load_order') }
  accepts_nested_attributes_for :setting_fields

  def to_param
    name
  end
end
