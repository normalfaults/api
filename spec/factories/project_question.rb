FactoryGirl.define do
  factory :project_question do
    question 'Question?'
    field_type 'mock'
    help_text 'helping'
    options %w(one tow three).to_s
    required true

    trait :optional do
      required false
    end
  end
end
