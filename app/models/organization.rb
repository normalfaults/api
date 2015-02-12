# == Schema Information
#
# Table name: organizations
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  img         :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  deleted_at  :datetime
#
# Indexes
#
#  index_organizations_on_deleted_at  (deleted_at)
#

class Organization < ActiveRecord::Base
  acts_as_paranoid
end
