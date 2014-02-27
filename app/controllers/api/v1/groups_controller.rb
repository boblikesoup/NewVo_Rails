class API::V1::GroupsController < API::V1::ApplicationController

  # done
  def create
    @group = Group.new(creator_id: @current_user.id, user_id: params[:user_id], title: params[:title], description: params[:description])
    if @group.save
      response = {}
      response["success"] = true
      response["data"] = @group
      render json: response
    else
      render json: {success: false, message: "There has been a problem creating this group"}
    end
  end

  # done
  def show
    @group = Group.find(params[:id])
    response = {}
    response["success"] = true
    response["data"] = @group
    render json: response
  end

  # done
  def add_members
    @group = Group.find(params[:id])
    @group.user_id << params[:user_id]
    if @group.save
      response = {}
      response["success"] = true
      response["Group Members"] = @group.user_id
      response["message"] = "You have successfully added members to your group."
      render json: response
    else
      render json: {success: false, message: "Houston, we have a problem"}
    end
  end

  # done
  def destroy
    if @group = Group.find(params[:id])
      @group.destroy!
      render json: {success: true, message: "You have successfully deleted your group"}
    else
      render json: {success: false, message: "Houston, we have a problem"}
    end
  end

end