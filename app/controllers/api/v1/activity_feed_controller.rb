class API::V1::ActivityFeedController < ApplicationController
  respond_to :json

  def index
    @activity = []
    two_weeks_ago = Time.now - 2.weeks
    votes = VoteActivity.where("notified_user_id = ?", current_user.id).where("created_at > ?", two_weeks_ago)
    followings = FollowingActivity.where("notified_user_id = ?", current_user.id).where("created_at > ?", two_weeks_ago)
    friendships = FriendshipActivity.where("notified_user_id = ?", current_user.id).where("created_at > ?", two_weeks_ago)
    #add thumbnails and usernames
    #add db entries for activities
    respond_with(@activity)
  end

  before_filter :set_current_user

end

