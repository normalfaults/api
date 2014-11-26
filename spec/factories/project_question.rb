FactoryGirl.define do
  factory :project_question do
    question 'Question?'
    field_type :text
    help_text 'helping'
    options %w(one tow three)
    required true

    trait :optional do
      required false
    end
  end
end
