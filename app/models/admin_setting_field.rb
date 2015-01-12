class AdminSettingField < ActiveRecord::Base
  belongs_to :admin_setting

  store_accessor :options

  enum field_type: [:check_box, :select_option, :text, :date]
end
