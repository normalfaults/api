FactoryGirl.define do
  factory :alert do
    project_id '0'
    staff_id '0'
    status 'OK'
    message 'test alert'

    trait :first do
      project_id '1'
      staff_id '1'
      status 'WARNING'
      message 'first alert'
    end

    trait :second do
      project_id '2'
      staff_id '2'
      status 'CRITICAL'
      message 'second alert'
    end

    trait :third do
      project_id '1'
      staff_id '1'
      status 'UNKNOWN'
      message 'third alert'
    end
  end
end
