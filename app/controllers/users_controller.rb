class UsersController < ApplicationController


  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      sign_in!(@user)
      flash[:notices] = ["User saved"]
      redirect_to root_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def destroy
    @user = User.find(params[:id])

    @user.destroy!
    flash[:notices] = ["User destroyed"]
    redirect_to root_url
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :username)
  end

end
