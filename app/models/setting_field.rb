# == Schema Information
#
# Table name: setting_fields
#
#  id         :integer          not null, primary key
#  label      :string(255)
#  field_type :integer          default(0)
#  help_text  :string(255)
#  options    :json
#  value      :string(255)
#  required   :string(1)
#  load_order :integer
#  created_at :datetime
#  updated_at :datetime
#  setting_id :integer
#
# Indexes
#
#  index_setting_fields_on_setting_id  (setting_id)
#

class SettingField < ActiveRecord::Base
  belongs_to :setting

  store_accessor :options

  enum field_type: [:check_box, :select_option, :text, :date, :password]
end
