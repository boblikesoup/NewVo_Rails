class API::V1::ApplicationController < ActionController::Base
  respond_to :json
  before_action :authorize, unless: :sessions_controller?
  before_action :signed_in?, unless: :sessions_controller?
  before_action :set_current_user, unless: :sessions_controller?
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token

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

  def set_current_user
    User.current = @current_user
  end

end
