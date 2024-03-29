class API::V1::SessionsController < API::V1::ApplicationController
  respond_to :json

  # done
  def create
    client = OAuth2::Client.new(
      ENV['FACEBOOK_APP_ID'],
      ENV['FACEBOOK_APP_SECRET'],
      site: 'https://graph.facebook.com')
    facebook_token = OAuth2::AccessToken.new(client, params[:fbtoken])
    user_info = ActiveSupport::JSON.decode(facebook_token.get('/me').body)
    picture_info = ActiveSupport::JSON.decode(facebook_token.get('/me?fields=picture').body)
    if user_info && picture_info
      @user = User.find_or_create_from_user_info(user_info, picture_info)
      if @user
        valid_login_attempt
      else
        invalid_login_attempt
      end
    end
  end

  # TODO implement a better logout
  def destroy
    # id = @current_user.id
    # user = User.find(id)
    # user.newvo_token = nil
    # @current_user = nil
    render json: {success: true, message: "Signout was successful"}
  end

  private

  def invalid_login_attempt(message="Seems like you've been trying to give our associates at facebook a fake name and password. Watch it, punk.")
    render :json=> {:success=>false, :message=>message}, :status=>401
  end

  def valid_login_attempt
    puts @user.newvo_token
    render :json=> {
     :success=>true,
     :id=>@user.id,
     :newvo_token=>@user.newvo_token,
     :first_name => @user.first_name,
     :last_name => @user.last_name,
     :facebook_username => @user.facebook_username,
     :profile_pic => @user.profile_pic,
     :facebook_id => @user.fb_uid,
     :gender => @user.gender
      }
  end

end

