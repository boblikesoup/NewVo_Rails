class FollowingActivity < ActiveRecord::Base

  def assemble_json
    following_activity = {}
    following_activity[:id] = self.id
    following_activity[:created_at] = self.created_at
    following_activity[:other_user] = User.find(self.other_user_id).assemble_user
    return following_activity
  end

end
