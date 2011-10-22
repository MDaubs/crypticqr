class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :mobile_device?
  def mobile_device?
    request.user_agent =~ /Mobile|webOS/ || params[:mobile] == "1"
  end
end
