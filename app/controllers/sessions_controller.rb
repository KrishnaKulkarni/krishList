class SessionsController < ApplicationController

  def new
    @email_attempt = nil
    render :new
  end

  def create
    user = User.find_by_credentials(params[:user][:email],
    params[:user][:password])


    if user
      sign_in!(user)
      flash[:notices] = ["User signed in"]
      redirect_to root_url
    else
      @email_attempt = params[:user][:email]
      flash.now[:errors] = ["Invalid credentials"]
      render :new
    end
  end

  def destroy
    sign_out!
    flash[:notices] = ["Current user signed out"]
    redirect_to root_url
  end
end
