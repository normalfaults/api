# == Schema Information
#
# Table name: user_setting_options
#
#  id         :integer          not null, primary key
#  label      :string(255)
#  field_type :string(100)
#  help_text  :string(255)
#  options    :text
#  required   :boolean          default(TRUE)
#  created_at :datetime
#  updated_at :datetime
#  deleted_at :datetime
#
# Indexes
#
#  index_user_setting_options_on_deleted_at  (deleted_at)
#  index_user_setting_options_on_label       (label) UNIQUE
#

class UserSettingOption < ActiveRecord::Base
end
