class API::V1::UsersController < API::V1::ApplicationController
  respond_to :json

  def index
    response = {}
    response["success"] = true
    response["data"] = @current_user
    respond_with(response)
  end

  def show
    @user = User.find(params[:id])
    response = {}
    response["success"] = true
    response["data"] = @user
    respond_with(response)
  end
end

