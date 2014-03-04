class API::V1::GroupsController < API::V1::ApplicationController

  # done
  def create
    @group = Group.new(user_id: @current_user.id, member_ids: params[:member_ids], title: params[:title], description: params[:description])
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
    @group = Group.find(params[:group_id])
    puts @group.inspect
    puts @group.member_ids.inspect
    @group.member_ids.push(params[:member_ids])
    if @group.save
      response = {}
      response["success"] = true
      response["Group Members"] = @group.member_ids
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