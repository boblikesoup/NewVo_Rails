class API::V1::SessionsController < ApplicationController
  respond_to :json

  def create
    user = User.find_or_create_from_auth_hash(auth_hash)
    session[:user_id] = user.id
    redirect_to api_v1_posts_path
  end

  def destroy
    session[:user_id] = nil
    #might need to redirect here to api_v1
    redirect_to root_path
  end

  def fb_sso
    client = OAuth2::Client.new(
      ENV['FACEBOOK_APP_ID'],
      ENV['FACEBOOK_APP_SECRET'],
      site: 'https://graph.facebook.com')
    facebook_token = OAuth2::AccessToken.new(client, params[:facebook_token])
    user_info = ActiveSupport::JSON.decode(facebook_token.get('/me').body)

    #need to log them in as current user
    #sign in using Devise method: sign_in @user, :event => :authentication #this will throw if @user is not activated
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end

end