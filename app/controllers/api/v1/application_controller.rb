class API::V1::ApplicationController < ActionController::Base
  before_action :authorize, unless: :sessions_controller?
  respond_to :json

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :signed_in?

  def authorize
    authenticate_or_request_with_http_token do |token|
      @current_user = User.find_by(newvo_token: token)
    end
  end

  def signed_in?
    !@current_user.nil?
  end

  def sessions_controller?
    params[:controller] == "api/v1/sessions"
  end

end
