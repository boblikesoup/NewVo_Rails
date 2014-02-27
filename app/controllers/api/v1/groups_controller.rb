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

  def update
  end

  def destroy
  end

end