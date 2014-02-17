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

# Not sure exactly how to take serialized params, WIP
# def circuit_params
#   params.require(:circuit).permit(:title, :id, viewable_tasks:[], ... )
# end

def show
  @group = Group.find(params[:id])
  response = {}
  response["success"] = true
  response["data"] = @group
  respond_with(response)
end