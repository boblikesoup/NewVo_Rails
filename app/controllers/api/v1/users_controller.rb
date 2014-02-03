class API::V1::UsersController < API::V1::ApplicationController
  respond_to :json

  def index
    response = {}
    response["success"] = true
    response["result"] = @current_user
    respond_with(response)
  end

  def show
    response = {}
    response["success"] = true
    response["result"] = User.find(params[:id])
    respond_with(response)
  end
end

