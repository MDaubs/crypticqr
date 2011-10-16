class SessionsController < ApplicationController
  def update
    session[:password] = params[:password]
    redirect_to root_url
  end

  def destroy
    session[:password] = nil
    redirect_to root_url
  end
end
