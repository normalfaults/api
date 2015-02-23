# require_relative 'seeds/products'
# require_relative 'seeds/project_questions'
# require_relative 'seeds/staff.rb'

# Settings Seeds
YAML.load_file(File.join(Rails.root, 'db', 'seeds', 'settings.yml')).each do |setting_data|
  setting = Setting.find_or_create_by hid: setting_data['hid']
  fields_data = setting_data.delete 'setting_fields'
  setting.update_attributes setting_data
  fields_data.each do |field_data|
    field = setting.setting_fields.find_or_create_by hid: field_data['hid']
    field.update_attributes field_data
  end
end
