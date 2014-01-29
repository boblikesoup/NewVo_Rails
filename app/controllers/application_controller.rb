class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :signed_in?
  protect_from_forgery with: :exception
  helper :all

  def signed_in?
    !current_user.nil?
  end

  # def current_user
  #   current_user ||= User.find(session[:user_id]) if session[:user_id]
  # end

  def authorize
    current_user = User.find_by(params[:newvo_token])
    return current_user
  end

  def current_user
    current_user = authorize
    puts current_user
  end

end
