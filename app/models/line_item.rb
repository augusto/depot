class LineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart
  belongs_to :order
  
  validates :price, :numericality => {:greater_than_or_equal_to => 0.01}
  validates :quantity, :numericality => {:greater_than_or_equal_to => 1}
  
  def total_price
    quantity * price
  end
  
  def to_s
    "line_item{cart=#{cart.id};product=#{product.id};quantity=#{quantity};price=#{price}}\n"
  end
end
