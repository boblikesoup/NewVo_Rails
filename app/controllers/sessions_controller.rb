class SessionsController < ApplicationController
  def create
    user = User.find_or_create_from_auth_hash(auth_hash)
    session[:user_id] = user.id
    redirect_to posts_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  # For testing
  def fb_sso
    client = OAuth2::Client.new(
      ENV['FACEBOOK_APP_ID'],
      ENV['FACEBOOK_APP_SECRET'],
      site: 'https://graph.facebook.com')
    facebook_token = OAuth2::AccessToken.new(client, params[:fbtoken])
    user_info = ActiveSupport::JSON.decode(facebook_token.get('/me').body)
    user = User.find_or_create_from_user_info(user_info)
    if user
      valid_login_attempt
    else
      # Invalid Login Attempt is never used. Things blow up at user_info when params are bad.
      invalid_login_attempt
    end
  end

# Do we need this code at some point? Exchanges short term and long term tokens.
# https://graph.facebook.com/oauth/access_token?
#     client_id=APP_ID&
#     client_secret=APP_SECRET&
#     grant_type=fb_exchange_token&
#     fb_exchange_token=EXISTING_ACCESS_TOKEN

  private

  def auth_hash
    request.env['omniauth.auth']
  end

  def invalid_login_attempt(message="There has been an error with your login or password.")
    render :json=> {:success=>false, :message=>message}, :status=>401
  end

  def valid_login_attempt
    render :json=> {:success=>true, :id=>@user.id, :newvo_token=>@user.newvo_token }
  end

end
