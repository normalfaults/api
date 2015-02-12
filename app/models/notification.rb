# == Schema Information
#
# Table name: notifications
#
#  id         :integer          not null, primary key
#  text       :text
#  ago        :text
#  staff_id   :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_notifications_on_staff_id  (staff_id)
#

class Notification < ActiveRecord::Base
end
