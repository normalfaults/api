FactoryGirl.define do
  factory :alert do
    project_id '1'
    staff_id '0'
    order_id '2'
    status 'OK'
    message 'THIS IS A BASIC TEST'
    start_date 'NULL'
    end_date 'NULL'

    trait :active do
      project_id '2'
      staff_id '0'
      order_id '2'
      status 'OK'
      message 'This is an active alert'
      start_date "#{DateTime.now}" # START DATE NOW
      end_date "#{DateTime.now + 1.day}" # END DATE NOT SET
    end

    trait :inactive do
      project_id '2'
      staff_id '0'
      order_id '2'
      message 'This is an inactive alert'
      start_date "#{DateTime.now - 2.days}" # YESTERDAY - 1
      end_date "#{DateTime.now - 1.day}" # YESTERDAY
    end

    trait :first do
      project_id '3'
      staff_id '0'
      order_id '1'
      status 'WARNING'
      message 'This is a WARNING alert for the first service of project 3.'
    end

    trait :second do
      project_id '3'
      staff_id '0'
      order_id '2'
      status 'CRITICAL'
      message 'This is a CRITICAL alert for the second service of project 3'
    end

    trait :third do
      project_id '3'
      staff_id '0'
      order_id '3'
      status 'UNKNOWN'
      message 'This is an UNKNOWN alert for the third service of project 3'
    end

    trait :warning do
      project_id '4'
      staff_id '0'
      order_id '1'
      status 'WARNING'
      message 'This is a WARNING alert for the first service of project 4.'
    end

    trait :critical do
      project_id '4'
      staff_id '0'
      order_id '1'
      status 'CRITICAL'
      message 'This is a CRITICAL alert for the first service of project 4.'
    end

    trait :unknown do
      project_id '4'
      staff_id '0'
      order_id '1'
      status 'UNKNOWN'
      message 'This is an UNKNOWN alert for the first service of project 4.'
    end
  end
end
