class Setting < ActiveRecord::Base
  has_many :setting_fields,  -> { order('load_order') }
  accepts_nested_attributes_for :setting_fields

  def to_param
    name
  end
end
