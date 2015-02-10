class SettingField < ActiveRecord::Base
  belongs_to :setting

  store_accessor :options

  enum field_type: [:check_box, :select_option, :text, :date]

  def disabled
    @disabled || 'false'
  end

  def disabled=(disabled)
    @disabled = disabled
  end
end
