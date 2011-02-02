class CopyProductPriceToLineItem < ActiveRecord::Migration
  def self.up
    LineItem.all.each do |line_item|
      line_item.update_attribute :price, line_item.product.price
    end
  end

  def self.down
  end
end
