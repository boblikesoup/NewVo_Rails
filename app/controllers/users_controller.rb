class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @profile = true
    @posts_page = false
  end
end