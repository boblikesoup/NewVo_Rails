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

  def description
    @user = User.find(params[:id])
    if @user.description != params[:description]
    @user.update_attributes(description: params[:description])
    @user.save
    response = {}
    response["success"] = true
    response["new_description"] = @user.description
    render json: response
    else
    render json: {success: false, message: "You've tried to update your description with your current description. Try again, buddy."}
    end
  end
end

# /api/v1/users/1/describe?newvo_token=67lpujuyKv7jcJpj4x8iYJWKTDta5NwU&description=I am the god of hellfire