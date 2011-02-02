class AddProductPriceToLineItem < ActiveRecord::Migration
  def self.up
    add_column :line_items, :price, :decimal, :precision => 8, :scale => 2
  end

  def self.down
    remove_column :line_items, :price
  end
end
