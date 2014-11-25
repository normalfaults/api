FactoryGirl.define do
  factory :user_setting do
    name 'test user setting'
    value 'test user value'

    trait :first do
      name 'first user setting'
      value 'first user value'
    end

    trait :second do
      name 'second user setting'
      value 'second user value'
    end

    trait :third do
      name 'third user setting'
      value 'third user value'
    end
  end
end
