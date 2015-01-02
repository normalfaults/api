class AdminSettingField < ActiveRecord::Base
  belongs_to :admin_setting

  scope :ordered, -> { order('load_order') }

  store_accessor :options

  enum field_type: [:check_box, :select_option, :text, :date]
end