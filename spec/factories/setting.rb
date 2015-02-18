FactoryGirl.define do
  factory :setting do
    name 'test settings'

    sequence :hid do |n|
      "hid_#{n}"
    end
  end
end
