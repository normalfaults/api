FactoryGirl.define do
  factory :project_question do
    question 'Question?'
    field_type :select_option
    help_text 'helping'
    options %w(one tow three)
    required true
    load_order 0

    trait :optional do
      required false
    end

    trait :required_text do
      field_type :text
      load_order 1
      options %w()
    end
  end
end
