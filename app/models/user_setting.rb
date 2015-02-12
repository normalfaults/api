# == Schema Information
#
# Table name: user_settings
#
#  id         :integer          not null, primary key
#  staff_id   :integer
#  name       :string(255)
#  value      :text
#  created_at :datetime
#  updated_at :datetime
#  deleted_at :datetime
#
# Indexes
#
#  index_user_settings_on_deleted_at         (deleted_at)
#  index_user_settings_on_staff_id_and_name  (staff_id,name) UNIQUE
#

class UserSetting < ActiveRecord::Base
  # acts_as_paranoid - NOT INCLUDING FOR USER SETTINGS
end
