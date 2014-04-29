class GroupsController < ApplicationController
  respond_to :html, :json

  #api version
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

  #api version
  def show
    @group = Group.find(params[:id])
    response = {}
    response["success"] = true
    response["data"] = @group
    render json: response
  end

  #api version
  def add_members
    @group = Group.find(params[:group_id])
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

  #api version
  def destroy
    if @group = Group.find(params[:id])
      @group.destroy!
      render json: {success: true, message: "You have successfully deleted your group"}
    else
      render json: {success: false, message: "Houston, we have a problem"}
    end
  end

end