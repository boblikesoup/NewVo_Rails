class API::V1::FollowingsController < API::V1::ApplicationController
  respond_to :json

  def create
    if @current_user.follow!(params[:followed_id])
      render json: {success: true, message: "following created", follower_id: @current_user.id, followed_id: params[:followed_id]}
    else
      render json: {success: false}
    end
    if @current_user.both_following?(params[:followed_id])
      @current_user.create_friendship(params[:followed_id])
      render json: {message: "friendship created"}
    end
  end

  def destroy
    #id = other user's id NOT of relationship
    following = Following.find_by(follower_id: @current_user.id, followed_id: params[:id])
    if @current_user.both_following?(following.followed_id)
      @current_user.destroy_friendship(following.followed_id)
    else
      FollowingActivity.published.find_by(notified_user_id: @current_user.id, following_id: params[:id], followed_type: "follower").update_attributes(status: FollowingActivity::STATUS_UNPUBLISHED)
      FollowingActivity.published.find_by(notified_user_id: params[:id], following_id: @current_user.id, followed_type: "followed").update_attributes(status: FollowingActivity::STATUS_UNPUBLISHED)
    end
    following.destroy!
  end
end