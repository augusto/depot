require 'test_helper'

class CartTest < ActiveSupport::TestCase
  fixtures :products
  
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  
  test "selecting a product twice increments quantity" do
    cart = Cart.create
    
    cart.add_product( products(:ruby).id )
    assert_equal(1, cart.line_items.count)
    
    cart.add_product( products(:ruby).id )
    assert_equal(1, cart.line_items.count)
    assert_equal(2, cart.line_items.first.quantity)
  end
  
  test "adding product to cart sets price on line item" do
    cart = Cart.create
    book = products(:ruby)
    cart.add_product( book.id )
    assert_equal( book.price, cart.line_items.first.price)
  end
  
  test "can select different products" do
    cart = Cart.create
    
    cart.add_product( products(:ruby).id )
    assert_equal(1, cart.line_items.count)
    
    cart.add_product( products(:rails_test_prescriptions).id )
    assert_equal(2, cart.line_items.count)
  end

end
