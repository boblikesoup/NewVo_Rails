class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @profile = true
  end
end