module DeviseRequestHelper
  def sign_in_as(staff)
    post_via_redirect staff_session_path, 'staff[email]' => staff.email, 'staff[password]' => staff.password
  end
end

RSpec.configure do |config|
  config.include DeviseRequestHelper, type: :request
end

RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
end
