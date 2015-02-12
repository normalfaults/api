FactoryGirl.define do
  factory :order do
    staff

    trait :with_items do

      transient do
        items_count 2
      end

      after :create do |order, eva|
        project = create :project
        create_list :order_item, eva.items_count, order: order, project: project
      end

    end
  end
end
