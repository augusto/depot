class Cart < ActiveRecord::Base
  has_many :line_items, :dependent => :destroy
  
  def add_product(product_id)
    line_item = line_items.where(:product_id => product_id).first
    if( line_item )
      line_item.quantity +=1
    else
      line_item = LineItem.new(:product_id => product_id)
      line_items << line_item
    end
    
    line_item
  end
  
  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end
end
