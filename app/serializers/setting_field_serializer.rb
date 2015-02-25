class SettingFieldSerializer < ApplicationSerializer
  attributes :id, :hid, :setting_id, :label, :help_text, :field_type, :field_options, :value
  attributes :load_order, :required, :disabled, :secret, :value_withheld, :env_var_name

  # Declare a second time to keep position but rename the key
  attribute :field_options, key: :options

  has_one :setting

  def value
    object.secret? ? nil : object.value
  end

  # Useful for letting clients know a value has been set when it is secret
  def value_withheld
    object.secret? && object.value.present?
  end

  # To get around a name clash in ActiveModelSerializer 0.8.0
  def field_options
    object.options
  end
end
