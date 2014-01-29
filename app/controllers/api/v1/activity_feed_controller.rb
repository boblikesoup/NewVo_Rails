class API::V1::ActivityFeedController < ApplicationController
  respond_to :json

  def index
    #destroy irrelevnt activities
    @activity = {}
    two_weeks_ago = Time.now - 2.weeks

    vote_activity_queries = VoteActivity.where("notified_user_id = ?", current_user.id).where("created_at > ?", two_weeks_ago)
    vote_activities = []
    vote_activity_queries.each do |activity|
      vote_activities << activity.assemble_json
    end
    @activity["vote_activities"] = vote_activities

    following_activity_queries = FollowingActivity.where("notified_user_id = ?", current_user.id).where("created_at > ?", two_weeks_ago).where("followed_type = ?", "followed")
    following_activities = []
    following_activity_queries.each do |activity|
      following_activities << activity.assemble_json
    end
    @activity["following_activities"] = following_activities

    friendships_activity_queries = FriendshipActivity.where("notified_user_id = ?", current_user.id).where("created_at > ?", two_weeks_ago)
    friendships_activity_queries = FollowingActivity.where("notified_user_id = ?", current_user.id).where("created_at > ?", two_weeks_ago).where("followed_type = ?", "followed")
    friendships_activities = []
    friendships_activity_queries.each do |activity|
      friendships_activities << activity.assemble_json
    end
    @activity["friendships_activities"] = friendships_activities

    respond_with(@activity)
  end

end

