class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :signed_in?, :set_current_user

  def signed_in?
    !current_user.nil?
  end

  def current_user
    current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def set_current_user
    User.current = current_user
  end

end
