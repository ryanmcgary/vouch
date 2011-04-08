require 'test_helper'

class RemoteurlsControllerTest < ActionController::TestCase
  setup do
    @remoteurl = remoteurls(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:remoteurls)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create remoteurl" do
    assert_difference('Remoteurl.count') do
      post :create, :remoteurl => @remoteurl.attributes
    end

    assert_redirected_to remoteurl_path(assigns(:remoteurl))
  end

  test "should show remoteurl" do
    get :show, :id => @remoteurl.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @remoteurl.to_param
    assert_response :success
  end

  test "should update remoteurl" do
    put :update, :id => @remoteurl.to_param, :remoteurl => @remoteurl.attributes
    assert_redirected_to remoteurl_path(assigns(:remoteurl))
  end

  test "should destroy remoteurl" do
    assert_difference('Remoteurl.count', -1) do
      delete :destroy, :id => @remoteurl.to_param
    end

    assert_redirected_to remoteurls_path
  end
end
