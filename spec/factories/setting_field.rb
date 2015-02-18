FactoryGirl.define do
  factory :setting_field do
    value ''
    field_type :text
    load_order 1
    help_text 'AWS Access Key'
    options []

    sequence :hid do |n|
      "hid_#{n}"
    end

    trait :select_box do
      field_type :select_box
      options %w(a b c)
      value 'a'
    end

    trait :check_box do
      field_type :select_box
      value 'false'
    end

    trait :date do
      field_type :date
      value '2014-01-01'
    end
  end
end
