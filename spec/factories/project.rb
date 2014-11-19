FactoryGirl.define do
  factory :project do
    name 'Test Project'
    description 'A description'
    cc '--cc--'
    staff_id '-staff_id--'
    budget 100.0
    start_date((DateTime.now + 1.week).to_date)
    end_date((DateTime.now + 2.week).to_date)
    approved true
    img '--img--'

    trait :unapproved do
      approved false
    end
  end
end
