require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should login" do
    dave = users(:one)
    post :create, :name => dave.name, :password => 'secret'
    assert_redirected_to admin_url
    assert_equal dave.id, session[:user_id]
  end

  test "should fail login" do
    dave = users(:one)
    post :create, :name => dave.name, :password => 'wrong'
    assert_response :success
    assert_select '#notice', 'Invalid user/password combination'
  end

  test "should logout via form" do
    delete :destroy
    assert_redirected_to store_url
  end

  test "should logout via link" do
    get :destroy
    assert_redirected_to store_url
  end


end
