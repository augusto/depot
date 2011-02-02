require 'test_helper'

class LineItemTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  
  test "line items attributes must not be empty" do 
    product = LineItem.new 
    assert product.invalid? 
    assert product.errors[:price].any? 
  end
  
  test "line item price must contain price" do
    product = LineItem.new 
    product.price = -1
    assert product.invalid?
    assert product.errors[:price].any? 
    
    product.price = 1
    assert product.valid?
  end
end
