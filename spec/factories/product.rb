FactoryGirl.define do
  factory :product do
    options nil
    active true
    img 'product.png'

    sequence :name do |n|
      "Product Name #{n}"
    end
    sequence :description do |n|
      "Product description #{n}"
    end
    sequence :service_type_id
    sequence :service_catalog_id
    sequence :chef_role do |n|
      "role_#{n}"
    end

    product_type

    after :create do |product, eva|
      product.product_type.questions.each do |question|
        create :product_answer, product: product, product_type_question_id: question.id
      end
    end
  end
end
