FactoryGirl.define do
  factory :alert do
    project_id '0'
    staff_id '0'
    status 'OK'
    message 'test alert'
    start_date 'NULL'
    end_date 'NULL'

    trait :active do
      project_id '0'
      staff_id '0'
      status 'OK'
      message 'This is an active alert'
      start_date "#{DateTime.now}" # START DATE NOW
      end_date "#{DateTime.now + 1.day}" # END DATE NOT SET
    end

    trait :inactive do
      project_id '0'
      staff_id '0'
      status 'OK'
      message 'This is an inactive alert'
      start_date "#{DateTime.now - 2.days}" # YESTERDAY - 1
      end_date "#{DateTime.now - 1.day}" # YESTERDAY
    end

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
