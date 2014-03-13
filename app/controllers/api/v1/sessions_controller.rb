class API::V1::SessionsController < API::V1::ApplicationController
  respond_to :json

  # done
  def create
    client = OAuth2::Client.new(
      ENV['FACEBOOK_APP_ID'],
      ENV['FACEBOOK_APP_SECRET'],
      site: 'https://graph.facebook.com')
    puts "11111111111111111111111111111111111"
    facebook_token = OAuth2::AccessToken.new(client, params[:fbtoken])
    puts "22222222222222222222222222222222222"
    user_info = ActiveSupport::JSON.decode(facebook_token.get('/me').body)
    puts "33333333333333333333333333333333333"
    picture_info = ActiveSupport::JSON.decode(facebook_token.get('/me?fields=picture').body)
    puts "44444444444444444444444444444444444"
    if user_info && picture_info
      @user = User.find_or_create_from_user_info(user_info, picture_info)
      puts "666666666666666666666666666666666"
      if @user
        valid_login_attempt
      else
        invalid_login_attempt
      end
    end
  end

  # done
  def destroy
    # id = @current_user.id
    # user = User.find(id)
    # user.newvo_token = nil
    @current_user = nil
    render json: {success: true, message: "Signout was successful"}
  end

  private

  def invalid_login_attempt(message="Seems like you've been trying to give our associates at facebook a fake name and password. Watch it, punk.")
    render :json=> {:success=>false, :message=>message}, :status=>401
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
     :facebook_id => @user.fb_uid,
     :gender => @user.gender
      }
  end

end

