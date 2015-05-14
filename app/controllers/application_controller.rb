class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :logged_in?

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !!current_user
  end

  def login_user!
    session[:session_token] = @user.reset_session_token!
  end

  def logout_user!
    current_user.reset_session_token!
    session[:session_token] = nil
  end

  def require_login
    unless logged_in?
      flash[:notice] = "You must be logged in to view that page."
      redirect_to new_session_url
    end
  end

  def require_logout
    if logged_in?
      redirect_to user_url(current_user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
