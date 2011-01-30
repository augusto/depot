class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :prepare_time_for_display
  
  def prepare_time_for_display
    @current_time = Time.now
  end

end
