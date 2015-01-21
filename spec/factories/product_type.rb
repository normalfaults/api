FactoryGirl.define do
  factory :product_type do
    sequence :name do |n|
      "Generic Type #{n}"
    end

    sequence :description do |n|
      "Generic type description #{n}."
    end

    transient do
      questions_count 2
      products_count 2
    end

    after :create do |product_type, eva|
      create_list :product_type_question, eva.questions_count, product_type: product_type
      create_list :product, eva.products_count, product_type: product_type
    end
  end
end
