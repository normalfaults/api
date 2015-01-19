FactoryGirl.define do
  factory :product_type_question do
    sequence :label do |n|
      "Label #{n}"
    end
    field_type 'text'
    required true
    sequence :load_order
    sequence :manageiq_key do |n|
      "key_#{n}"
    end
    product_type
  end
end
