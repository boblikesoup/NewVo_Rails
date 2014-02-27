class API::V1::UsersController < API::V1::ApplicationController
  respond_to :json

  # done
  def index
    response = {}
    response["success"] = true
    response["data"] = @current_user
    render json: response
  end

  # done
  def show
    @user = User.find(params[:id])
    response = {}
    response["success"] = true
    response["data"] = @user
    render json: response
  end

  # done
  def description
    if @current_user.description != params[:description]
    @current_user.update_attributes(description: params[:description])
    @current_user.save
    response = {}
    response["success"] = true
    response["new_description"] = @current_user.description
    response["message"] = "You have successfully changed your description."
    render json: response
    else
    render json: {success: false, message: "You've tried to update your description with your current description. Try again, buddy."}
    end
  end
end