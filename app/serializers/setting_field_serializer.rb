class SettingFieldSerializer < ApplicationSerializer
  attributes :id, :hid, :setting_id, :label, :help_text, :field_type, :field_options, :value, :load_order,
    :required, :disabled, :secret, :setting_given, :env_var_name

  # Declare a second time to keep position but rename the key
  attribute :field_options, key: :options

  has_one :setting

  def value
    '' if object.secret?
  end

  # Useful for letting clients know a value has been set when it is secret
  def setting_given
    object.value.present?
  end

  # To get around a name clash in ActiveModelSerializer 0.8.0
  def field_options
    object.options
  end
end
