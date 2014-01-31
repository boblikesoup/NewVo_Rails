class API::V1::FollowingsController < API::V1::ApplicationController
  respond_to :json

  def create
    @current_user.follow!(params[:followed_id])
    if @current_user.both_following?(params[:followed_id])
      @current_user.create_friendship(params[:followed_id])
    end
  end

  def destroy
    following = Following.find(params[:id])

    if @current_user.both_following?(following.followed_id)
      @current_user.destroy_friendship(following.followed_id)
    end

    following.destroy!
  end
end