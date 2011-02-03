require 'test_helper'

class CartsControllerTest < ActionController::TestCase
  setup do
    @cart = carts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:carts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cart" do
    assert_difference('Cart.count') do
      post :create, :cart => @cart.attributes
    end

    assert_redirected_to cart_path(assigns(:cart))
  end

  test "should show cart" do
    get :show, :id => @cart.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @cart.to_param
    assert_response :success
  end

  test "should update cart" do
    put :update, :id => @cart.to_param, :cart => @cart.attributes
    assert_redirected_to cart_path(assigns(:cart))
  end

  test "should destroy cart" do
    @request.session[:cart_id] = carts(:ruby_cart).id
    
    assert_difference('Cart.count', -1) do
      delete :destroy, :id => carts(:ruby_cart).id
    end

    assert_redirected_to store_path
  end
  
  test "remove cart when cart is emptied" do
    @request.session[:cart_id] = carts(:ruby_cart).id
    
    assert_difference('Cart.count', -1) do
      xhr :delete, :destroy, :id => carts(:ruby_cart).id
    end
    assert_response :success 
    
    # unfortunately assert_select_rjs doesn't understand :visual_effect 
    # http://apidock.com/rails/ActionController/Assertions/SelectorAssertions/assert_select_rjs
    #assert_select_rjs :visual_effect, :blind_up, 'cart'
  end
end
