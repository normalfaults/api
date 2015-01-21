FactoryGirl.define do
  factory :product_answer do
    sequence :answer do |n|
      "answer #{n}"
    end
    product
    product_type_question_id nil
  end
end
