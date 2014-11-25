FactoryGirl.define do
  factory :project_answer do
    association :project_question, strategy: :create
    association :project, strategy: :create
  end
end
