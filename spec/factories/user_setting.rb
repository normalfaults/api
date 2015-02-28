FactoryGirl.define do
  factory :user_setting do
    sequence :name do |n|
      "name #{n}"
    end

    sequence :value do |n|
      "value #{n}"
    end

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
