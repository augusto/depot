class Cart < ActiveRecord::Base
  has_many :line_items, :dependent => :destroy
  
  def add_product(product_id)
    product = Product.find(product_id)
    line_item = line_items.where(:product_id => product_id).first
    if line_item 
      line_item.quantity += 1
    else
      line_item = LineItem.new(:product_id => product_id, :price => product.price)
      line_items << line_item
    end
    
    line_item.save
    line_item
  end
  
  def remove_product(product_id)
    line_item = line_items.where(:product_id => product_id).first
    
    if ! line_item
      print "wohoo... what happened, I didn't get a product id"
      return
    end  

    line_item.quantity -= 1
    if line_item.quantity == 0
      line_items.delete line_item
      line_item.delete
    else
      line_item.save
    end

  end
  
  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end
end
