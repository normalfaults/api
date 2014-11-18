FactoryGirl.define do

  factory :staff do
    first_name 'Test'
    last_name 'Staff'
    email 'staff@test.com'
    role 'user'
    password 'test_pass'

    trait :user do
      email 'user@test.com'
    end

    trait :admin do
      email 'admin@test.com'
      role 'admin'
    end
  end
end
