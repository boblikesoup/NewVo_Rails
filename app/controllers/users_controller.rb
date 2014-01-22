class UsersController < ApplicationController

respond_to :html, :json

  def index
    respond_with(current_user)
  end

  def show
    @user = User.find(params[:id])
    @profile = true
    @posts_page = false
    respond_with(User.find(params[:id]))
  end
end