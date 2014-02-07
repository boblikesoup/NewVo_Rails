class API::V1::ActivityFeedController < API::V1::ApplicationController
  respond_to :json

  def index
    #destroy irrelevnt activities



    def join_activity(model)
      activity_queries = model.where("notified_user_id = ?", @current_user.id).where("created_at > ?", @two_weeks_ago).published
      activities = []
      activity_queries.each do |activity|
        activities << activity.assemble_json
      end
      return activities
    end

    @two_weeks_ago = Time.now - 2.weeks
    @activity = {}
    @activity["vote_activities"] = join_activity(VoteActivity)
    @activity["comment_activities"] = join_activity(CommentActivity)
    @activity["following_activities"] = join_activity(FollowingActivity)
    @activity["friendship_activities"] = join_activity(FriendshipActivity)
    response = {}
    response["success"] = true
    response["data"] = @activity
    respond_with(response)
  end

end

