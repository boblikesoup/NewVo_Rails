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

  def fb_sso
    client = OAuth2::Client.new(
      ENV['FACEBOOK_APP_ID'],
      ENV['FACEBOOK_APP_SECRET'],
      site: 'https://graph.facebook.com')
    facebook_token = OAuth2::AccessToken.new(client, params[:facebook_token])
    user_info = ActiveSupport::JSON.decode(facebook_token.get('/me').body)
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end

end