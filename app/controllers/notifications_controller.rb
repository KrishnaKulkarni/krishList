class NotificationsController < ApplicationController

  def index
    @user = User.find(params[:user_id])
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
