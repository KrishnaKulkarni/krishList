class NotificationsController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @header_options = { head_link_text: ["account", "notifications"],
       head_link_url: [user_ads_url(@user), user_notifications_url(@user)]
      }
    if(require_current_user_matches!(@user))
      @notifications = @user.notifications
      render :index
    end
  end

  #not safeguarded with require_current_user_matches!(@user))
  def viewed
    notification = Notification.find(params[:id])
    notification.update!(viewed: true)
    redirect_to user_notifications_url(current_user)
  end

end
