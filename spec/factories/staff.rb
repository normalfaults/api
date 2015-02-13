# == Schema Information
#
# Table name: staff
#
#  id                     :integer          not null, primary key
#  first_name             :string(255)
#  last_name              :string(255)
#  email                  :string(255)
#  phone                  :string(30)
#  created_at             :datetime
#  updated_at             :datetime
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  role                   :integer          default(0)
#  deleted_at             :datetime
#  authentication_token   :string(255)
#
# Indexes
#
#  index_staff_on_authentication_token  (authentication_token) UNIQUE
#  index_staff_on_deleted_at            (deleted_at)
#  index_staff_on_email                 (email) UNIQUE
#  index_staff_on_reset_password_token  (reset_password_token) UNIQUE
#

FactoryGirl.define do
  factory :staff do
    first_name 'Test'
    last_name 'Staff'
    sequence :email do |n|
      "staff_#{n}@test.com"
    end
    role 'user'
    password 'test_pass'
    secret 'test_token'

    created_at '2014-11-21T23:03:36.465Z'
    updated_at '2014-11-21T23:03:36.465Z'

    trait :user do
      sequence :email do |n|
        "user_#{n}@test.com"
      end
    end

    trait :admin do
      sequence :email do |n|
        "admin_#{n}@test.com"
      end
      role 'admin'
    end
  end
end
