class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token, if: :json_request?
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

  protected

  def json_request?
    request.format.json?
  end

end
