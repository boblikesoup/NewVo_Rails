class API::V1::FollowingsController < ApplicationController
  respond_to :json

  def create
    current_user.follow!(params[:followed_id])
    if current_user.both_following?(params[:followed_id])
      current_user.create_friendship(params[:followed_id])
      FriendshipActvitiy.create()
    end
  end

  def destroy
    if current_user.both_following?(params[:followed_id])
      current_user.destroy_friendship(params[:followed_id])
    end
    current_user.unfollow!(params[:followed_id])
  end
end