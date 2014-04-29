class ActivityFeedController < ApplicationController
  respond_to :html, :json

  #needs test
  def index
    @two_weeks_ago = Time.now - 2.weeks
    @activities = {}
    @activities["vote_activities"] = join_activity(VoteActivity)
    @activities["comment_activities"] = join_activity(CommentActivity)
    @activities["following_activities"] = join_activity(FollowingActivity)
    @activities["friendship_activities"] = join_activity(FriendshipActivity)
    response = {}
    response["success"] = true
    response["data"] = @activities
    respond_with(response)
  end

  def join_activity(model)
      activity_queries = model.where("notified_user_id = ?", current_user.id).where("created_at > ?", @two_weeks_ago).published
      activities = []
      activity_queries.each do |activity|
        activities << activity.assemble_json
      end
    return activities
  end

end

