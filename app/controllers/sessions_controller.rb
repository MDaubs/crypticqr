class SessionsController < ApplicationController
  def update
    unless params[:password].empty?
      session[:password] = params[:password]
    else
      session[:password] = nil
      flash[:alert] = "You must specify a non-blank password."
    end
    if session[:decode_qr_code]
      redirect_to "#{decode_url}?c=#{session.delete(:decode_qr_code)}"
    else
      redirect_to root_url
    end
  end

  def destroy
    session[:password] = nil
    redirect_to root_url
  end
end
