FactoryGirl.define do
  factory :staff do
    first_name 'Test'
    last_name 'Staff'
    email 'staff@test.com'
    role 'user'
    password 'test_pass'
    secret 'test_token'

    created_at '2014-11-21T23:03:36.465Z'
    updated_at '2014-11-21T23:03:36.465Z'

    trait :user do
      email 'user@test.com'
    end

    trait :admin do
      email 'admin@test.com'
      role 'admin'
    end
  end
end
