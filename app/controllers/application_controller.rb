class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :prepare_time_for_display, 
                :authorise
  
  def prepare_time_for_display
    @current_time = Time.now
  end
  
  def current_cart
    Cart.find session[:cart_id]
  rescue
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end
  
  private
  def authorise 
    unless User.find_by_id(session[:user_id])
      redirect_to login_url, :notice => "Please log in"
    end
  end
    
end
