class API::V1::ApplicationController < ActionController::Base

  respond_to :json
  before_action :authorize, unless: :sessions_controller?
  before_action :signed_in?, unless: :sessions_controller?
  before_action :set_current_user, unless: :sessions_controller?
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token

  rescue_from ActionController::RoutingError, :with => :route_not_found
  rescue_from ActiveRecord::RecordNotUnique, :with => :not_unique
  rescue_from ActionController::MethodNotAllowed, :with => :method_not_allowed
  rescue_from OAuth2::Error, :with => :login_error
  # rescue_from NoMethodError, :with => :no_method_error
  if (defined? ActiveRecord)
    rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  end

  # def no_method_error
  #   handle_error('no method error', :status => :not_found)
  # end

  def login_error
    handle_error('login failed', :status => :not_found)
  end

  def route_not_found(exception)
    handle_error('no route', :status => :not_found)
  end

  def not_unique(exception)
    handle_error('record not unique', :status => :not_found)
  end

  def method_not_allowed(exception)
    handle_error('method not allowed', :status => :not_found)
  end

  def record_not_found(exception)
    handle_error('no record', :status => :not_found)
  end

  def handle_error(message, params)
    error = {:error => message}
    status = params[:status] || :not_found

    respond_to do |format|
      format.json { render :json => error.to_json, :status => status }
    end
  end

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
