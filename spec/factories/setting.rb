FactoryGirl.define do
  factory :setting do
    name 'test setting'
    value 'test value'

    trait :first do
      name 'first setting'
      value 'first value'
    end

    trait :second do
      name 'second setting'
      value 'second value'
    end

    trait :third do
      name 'third setting'
      value 'third value'
    end
  end
end
