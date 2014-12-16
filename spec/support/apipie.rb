RSpec.configure do |config|
  # RSpec::Core::Configuration#treat_symbols_as_metadata_keys_with_true_values= is
  # deprecated, it is now set to true as default and setting it to false has no effect.
  #
  # config.treat_symbols_as_metadata_keys_with_true_values = true
  config.filter_run show_in_doc: true if ENV['APIPIE_RECORD']
end
