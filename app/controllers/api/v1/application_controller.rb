class API::V1::ApplicationController < ActionController::Base
  include ApplicationHelper
  respond_to :json
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper :all

  def authorize
    current_user = User.find_by(params[:newvo_token])
    return current_user
  end

  def mobile_current_user
    current_user = authorize
    current_user.exists?
  end

  def signed_in?
    !current_user.nil?
  end

end
