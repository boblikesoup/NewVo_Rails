class API::V1::SessionsController < API::V1::ApplicationController
  respond_to :json

# Do we need this code at some point? Exchanges short term and long term tokens.
# https://graph.facebook.com/oauth/access_token?
#     client_id=APP_ID&
#     client_secret=APP_SECRET&
#     grant_type=fb_exchange_token&
#     fb_exchange_token=EXISTING_ACCESS_TOKEN

  def create
    client = OAuth2::Client.new(
      ENV['FACEBOOK_APP_ID'],
      ENV['FACEBOOK_APP_SECRET'],
      site: 'https://graph.facebook.com')
    facebook_token = OAuth2::AccessToken.new(client, params[:fbtoken])
    # begin
    user_info = ActiveSupport::JSON.decode(facebook_token.get('/me').body)
    picture_info = ActiveSupport::JSON.decode(facebook_token.get('/me?fields=picture').body)
    # rescue OAuth2::Error
    #   invalid_login_attempt
    # rescue StandardError => e
    #   invalid_login_attempt
    # rescue NoMethodError
    #   invalid_login_attempt
    # end
    if user_info && picture_info
      @user = User.find_or_create_from_user_info(user_info, picture_info)
      if @user
        valid_login_attempt
      else
        invalid_login_attempt
      end
    end
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end

  def invalid_login_attempt(message="Seems like you've been trying to give our associates at facebook a fake name and password. Watch it, punk.")
    render :json=> {:success=>false, :message=>message}, :status=>401
    return
  end

  def valid_login_attempt
    render :json=> {
     :success=>true,
     :id=>@user.id,
     :newvo_token=>@user.newvo_token,
     :first_name => @user.first_name,
     :last_name => @user.last_name,
     :facebook_username => @user.facebook_username,
     :profile_pic => @user.profile_pic,
     :facebook_id => @user.fb_uid
      } and return
  end

end

