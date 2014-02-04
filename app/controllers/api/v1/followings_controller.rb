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
    #refactor this to clean methods and figure out if passing in id of user or following
    if @current_user.both_following?(following.followed_id)
      @current_user.destroy_friendship(following.followed_id)
    else
      following = Following.find_by(follower_id: self.id, followed_id: followed_id, status: FriendshipActivity::STATUS_PUBLISHED)
      FollowingActivity.find_by(notified_user_id: self.id, following_id: following.id, status: FollowingActivity::STATUS_PUBLISHED).status = FollowingActivity::STATUS_UNPUBLISHED
      FollowingActivity.find_by(notified_user_id: followed_id, following_id: following.id, status: FollowingActivity::STATUS_PUBLISHED).status = FollowingActivity::STATUS_UNPUBLISHED
    end

    following.destroy!
  end
end