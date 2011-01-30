class StoreController < ApplicationController
  def index
    @products = Product.all
    session[:counter] ||= 0
    session[:counter] += 1
  end

end
