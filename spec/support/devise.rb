module DeviseRequestHelper
  def sign_in_as(staff)
    post_via_redirect staff_session_path, 'staff[email]' => staff.email, 'staff[password]' => staff.password
  end

  def sign_in_with(email, password)
    post_via_redirect staff_session_path, 'staff[email]' => email, 'staff[password]' => password
  end

  def rest_sign_in(email, password)
    post '/staff/sign_in', staff: { email: email, password: password }
  end
end

RSpec.configure do |config|
  config.include DeviseRequestHelper, type: :request
end

RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
end
