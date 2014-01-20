class API::V1::SessionsController < ApplicationController
  respond_to :json

  def create
    client = OAuth2::Client.new(
      ENV['FACEBOOK_APP_ID'],
      ENV['FACEBOOK_APP_SECRET'],
      site: 'https://graph.facebook.com')
    facebook_token = OAuth2::AccessToken.new(client, params[:fbtoken])
    user_info = ActiveSupport::JSON.decode(facebook_token.get('/me').body)
    @user = User.find_or_create_from_user_info(user_info)
    if @user
      valid_login_attempt
    else
      # Invalid Login Attempt never used, see Sessions#fb_sso
      invalid_login_attempt
    end
  end

  def destroy
    session[:user_id] = nil
    #might need to redirect here to api_v1
    redirect_to root_path
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end

  private

  def invalid_login_attempt(message="There has been an error with your login or password.")
    render :json=> {:success=>false, :message=>message}, :status=>401
  end

  def valid_login_attempt
    render :json=> {:success=>true, :id=>@user.id, :newvo_token=>@user.newvo_token }
  end

end

