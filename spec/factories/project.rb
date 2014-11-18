FactoryGirl.define do

  factory :project do
    name 'Test Project'
    description 'A description'
    cc '--cc--'
    staff_id '-staff_id--'
    budget 100.0
    start_date (DateTime.now + 1.week).to_s
    end_date (DateTime.now + 2.week).to_s
    approved 'Y'
    img '--img--'
  end
end
