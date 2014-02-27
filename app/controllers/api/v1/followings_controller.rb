class API::V1::FollowingsController < API::V1::ApplicationController
  respond_to :json

  def create
    if follow!(params[:followed_id])
      render json: {success: true, message: "following created", follower_id: @current_user.id, followed_id: params[:followed_id]}
    end
    if both_following?(params[:followed_id])
      create_friendship(params[:followed_id])
    end
  end

  # params id = followed_id (the id of the followed user)
  def destroy
    following = Following.find_by(followed_id: params[:id], follower_id: @current_user.id)
    if both_following?(following.followed_id)
       destroy_friendship(following.followed_id)
    else
    FollowingActivity.published.find_by(notified_user_id: @current_user.id, following_id: params[:id], followed_type: "follower").update_attributes(status: FollowingActivity::STATUS_UNPUBLISHED)
    FollowingActivity.published.find_by(notified_user_id: params[:id], following_id: @current_user.id, followed_type: "followed").update_attributes(status: FollowingActivity::STATUS_UNPUBLISHED)
    following.destroy!
    end
    render json: {success: true, message: "following destroyed", follower_id: @current_user.id, followed_id: following.followed_id}
  end

  private

  def follow!(followed_id)
    following = Following.create!(follower_id: @current_user.id, followed_id: followed_id)
    FollowingActivity.create!(notified_user_id: @current_user.id, other_user_id: followed_id, followed_type: "follower", following_id: following.id)
    FollowingActivity.create!(notified_user_id: followed_id, other_user_id: @current_user.id, followed_type: "followed", following_id: following.id)
  end

  def both_following?(followed_id)
    if Following.exists?(follower_id: @current_user.id, followed_id: followed_id) && Following.exists?(follower_id: followed_id, followed_id: @current_user.id)
      return true
    else
      return false
    end
  end

  def create_friendship(followed_id)
    if friender = Friendship.create!(user_id: @current_user.id, friend_id: followed_id) && friended = Friendship.create(user_id: followed_id, friend_id: @current_user.id)
      FriendshipActivity.create!(notified_user_id: @current_user.id, other_user_id: followed_id, friendship_id: friender.id)
      FriendshipActivity.create!(notified_user_id: followed_id, other_user_id: @current_user.id, friendship_id: friended.id)
    end
  end

  def destroy_friendship(followed_id)
    following = Following.find_by(follower_id: @current_user.id, followed_id: followed_id)
    FollowingActivity.find_by(notified_user_id: @current_user.id, following_id: following.id, followed_type: "follower", status: FollowingActivity::STATUS_PUBLISHED).update_attributes(status: FollowingActivity::STATUS_UNPUBLISHED)
    FollowingActivity.find_by(notified_user_id: followed_id, following_id: following.id, followed_type: "followed", status: FollowingActivity::STATUS_PUBLISHED).status = FollowingActivity::STATUS_UNPUBLISHED
    following.destroy
    FriendshipActivity.published.find_by(notified_user_id: @current_user.id, other_user_id: followed_id).update_attributes(status: FriendshipActivity::STATUS_UNPUBLISHED)
    FriendshipActivity.published.find_by(notified_user_id: followed_id, other_user_id: @current_user.id).update_attributes(status: FriendshipActivity::STATUS_UNPUBLISHED)
    Friendship.find_by(user_id: @current_user.id, friend_id: followed_id).destroy
    Friendship.find_by(user_id: followed_id, friend_id: @current_user.id).destroy
  end

end