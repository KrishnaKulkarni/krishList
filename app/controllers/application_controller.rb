class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, signed_in?

  private
  def current_user
    @current_user ||= User.find_by(session_token: session[:token])
  end
  
  def sign_in!(user)
    user.reset_session_token!
    session[:token] = user.session_token
  end
  
  def sign_out!
    current)user.reset_session_token!
    session[:token] = nil
  end
  
  def signed_in?
    !!current_user
  end
  
  def require_signed_in!
    redirect_to new_session_url unless signed_in?
  end

end
