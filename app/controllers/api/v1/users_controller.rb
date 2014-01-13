class API::V1::UsersController < ApplicationController
  respond_to :json

  def index
    respond_with(current_user)
  end

  def show
    respond_with(User.find(params[:id]))
  end
end

