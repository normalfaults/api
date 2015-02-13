FactoryGirl.define do
  factory :approval do
    staff_id 1
    project_id 1
    approved true

    trait :unapproved do
      approved false
      reason 'Unapproved'
    end
  end
end
