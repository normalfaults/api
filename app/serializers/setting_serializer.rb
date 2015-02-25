class SettingSerializer < ApplicationSerializer
  attributes :id, :name, :hid

  has_many :setting_fields
end
