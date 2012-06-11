class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      flash[:success] = "Successfully logged in."
      sign_in user, permanent: params[:remember_me]
      redirect_to user_path(user)
    else 
      flash[:error] = "Error: Email and Password combination do not match our records."
      redirect_to signin_path
    end
  end

  def destroy
    sign_out
    redirect_to signin_path
  end
end
