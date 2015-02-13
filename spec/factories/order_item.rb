FactoryGirl.define do
  factory :order_item do
    order
    project
    product
  end
end
