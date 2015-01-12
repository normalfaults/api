class AdminSetting < ActiveRecord::Base
  has_many :admin_setting_fields

  belongs_to :admin_setting,  -> { order('load_order') }

  accepts_nested_attributes_for :admin_setting_fields

  def to_param
    name
  end
end
