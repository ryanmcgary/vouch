require 'test_helper'

class DashboardControllerTest < ActionController::TestCase
  test "should get install" do
    get :install
    assert_response :success
  end

  test "should get moderate" do
    get :moderate
    assert_response :success
  end

  test "should get admin" do
    get :admin
    assert_response :success
  end

end
