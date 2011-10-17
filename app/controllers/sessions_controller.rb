class SessionsController < ApplicationController
  def update
    unless params[:password].empty?
      session[:password] = params[:password]
    else
      session[:password] = nil
      flash[:alert] = "You must specify a non-blank password."
    end
    redirect_to root_url
  end

  def destroy
    session[:password] = nil
    redirect_to root_url
  end
end
