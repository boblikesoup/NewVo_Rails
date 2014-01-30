class API::V1::ApplicationController < ActionController::Base
  before_action :authorize, unless: :sessions_controller?
  before_filter :signed_in?, unless: :sessions_controller?
  respond_to :json
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper :all

  def authorize
      @current_user =
      User.find_by(newvo_token: params[:newvo_token]) ||
      authenticate_or_request_with_http_token do |newvo_token|
        User.find_by(newvo_token: newvo_token)
    end
  end

  def signed_in?
    !!@current_user
  end

  def sessions_controller?
    params[:controller] == "api/v1/sessions"
  end

end
