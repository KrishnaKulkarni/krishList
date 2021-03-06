class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @header_options = { head_link_text: ["account", "settings"],
       head_link_url: [user_ads_url(@user), users_url(@user)]
      }
    render :show if (require_current_user_matches!(@user))
 
  end

  def posted_ads
    @user = User.includes(:posted_ads).find(params[:user_id])
    @header_options = { head_link_text: ["account", "postings"],
       head_link_url: [user_ads_url(@user), user_ads_url(@user)]
      }
    render :posted_ads if (require_current_user_matches!(@user))
  end
  
  def alerts
    @user = User.includes(:alerts => :subcat).find(params[:user_id])
    @header_options = { head_link_text: ["account", "alerts"],
       head_link_url: [user_ads_url(@user), user_alerts_url(@user)]
      }
    render :alerts if (require_current_user_matches!(@user))
  end

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
    if(require_current_user_matches!(@user) || require_admin!)
      @user.destroy!
      flash[:notices] = ["User destroyed"]
      redirect_to root_url
    end
  end

  def edit
    @user = User.find(params[:id])
    render :edit
  end

  def update
    @user = User.find(params[:id])
    if(require_current_user_matches!(@user))
      if @user.update(user_params)
        flash[:notices] = ["User updated"]
        redirect_to user_url(@user)
      else
        flash.now[:errors] = @user.errors.full_messages
        render :edit
      end
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :username,
     :wants_forwarded_responses)
  end

end
