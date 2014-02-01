class API::V1::ActivityFeedController < API::V1::ApplicationController
  respond_to :json

  def index
    #destroy irrelevnt activities
    activity = {}
    two_weeks_ago = Time.now - 2.weeks

    def join_activity(model)
      activity_queries = model.where("notified_user_id = ?", @current_user.id).where("created_at > ?", two_weeks_ago).published
      activities = []
      activity_queries.each do |activity|
        activities << activity.assemble_json
      end
      activities
    end

    @activity["vote_activities"] = join_activity(VoteActivity)
    @activity["comment_activities"] = join_activity(CommentActivity)
    @activity["following_activities"] = join_activity(FollowingActivity)
    @activity["friendship_activities"] = join_activity(FriendActivity)

    respond_with(@activity)
  end

end

