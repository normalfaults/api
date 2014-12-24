class RealNumberValidator < Apipie::Validator::BaseValidator
  def validate(value)
    self.class.validate(value)
  end

  def self.build(param_description, argument, _options, _block)
    new(param_description) if argument == :real_number
  end

  def description
    'Must be a floating point number.'
  end

  def self.validate(value)
    value.to_s =~ /\A(0|[1-9]\d*)(\.\d*)?\Z$/
  end
end
