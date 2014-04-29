class UsersController < ApplicationController
respond_to :html, :json

  #needs test
  def index
    respond_with(current_user)
  end

  #needs test
  def show
    @user = User.find(params[:id])
    @profile = true
    @posts_page = false
    respond_with(@user)
  end

  #needs flash, test
  def description
    @user = User.find(params[:id])
    if @user.description != params[:description]
      @user.update_attributes(description: params[:description])
      @user.save
    end
  end
end