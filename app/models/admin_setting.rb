class AdminSetting < ActiveRecord::Base
  has_many :admin_setting_fields

  belongs_to :admin_setting

  def update_field_values_with_params!(field_params)
    AdminSettingField.transaction do
      field_params.each do |field_param|
        admin_setting_fields.update(field_param[:id], value: field_param[:value])
      end
    end
  end

  def to_param
    name
  end
end
