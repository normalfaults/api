require 'test_helper'

class AutomateControllerTest < ActionController::TestCase
  test 'should get catalog_item_initialization' do
    get :catalog_item_initialization
    assert_response :success
  end

  test 'should get update_servicemix_and_chef' do
    get :update_servicemix_and_chef
    assert_response :success
  end
end
