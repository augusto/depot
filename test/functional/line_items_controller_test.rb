require 'test_helper'

class LineItemsControllerTest < ActionController::TestCase
  
  setup do
    @line_item = line_items(:one)
    @update = {:product_id => products(:ruby).id,
               :quantity => 2,
               :price => 12.99}
    @session = {}    
    @session[:cart_id] = carts(:ruby_cart).id
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:line_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create line_item" do
    assert_difference('LineItem.count') do
      post :create, @update
    end

    assert_redirected_to store_path
  end

  test "should show line_item" do
    get :show, :id => @line_item.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @line_item.to_param
    assert_response :success
  end

  test "should update line_item" do
    put :update, :id => @line_item.to_param, :line_item => @update
    assert_redirected_to line_item_path(assigns(:line_item))
  end

  test "should destroy line_item when quantity reaches 0" do
    product = products(:ruby)
    delete :destroy, {:id => 0, :product_id => products(:rails_test_prescriptions).id}, @session

    cart = Cart.find(session[:cart_id]);
    assert cart.line_items.count == 1,"there should be one item left in the cart"
    assert_redirected_to store_url
  end
  
  test "should decrement quantity if it's greater than one" do
    product = products(:ruby)
    delete :destroy, {:id => 0, :product_id => products(:ruby).id}, @session

    cart = Cart.find(session[:cart_id]);
    assert_equal 2, cart.line_items.count
    cart.line_items.each do |line_item|
      assert_equal 1,  line_item.quantity, "line item for product #{line_item.product.title} has #{line_item.quantity}"
    end

    assert_redirected_to store_url
  end
  
  test "should create line_item via ajax" do 
    @request.session[:cart_id] = carts(:empty).id
    
    assert_difference('LineItem.count') do
      xhr :post, :create, :product_id => products(:ruby).id
    end
    assert_response :success 
    
    assert_select_rjs :replace_html, 'cart' do
      assert_select 'tr#current_item td', /Programming Ruby 1.9/
    end 
  end
end
