FactoryGirl.define do
  factory :user_setting_option do
    label 'test label'
    field_type 'text_area'
    help_text 'click here'
    options '{ "JSON PAYLOAD": "DATA" }'
    required true

    trait :first do
      label 'first label'
    end

    trait :second do
      label 'second label'
    end

    trait :third do
      label 'third label'
    end
  end
end
