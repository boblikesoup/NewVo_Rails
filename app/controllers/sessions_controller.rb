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
