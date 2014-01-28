class FollowingActivity < ActiveRecord::Base

  def assemble_json
    following_activity = {}
    following_activity[:created_at] = self.created_at
    following_activity[:other_user_id] = self.other_user_id
    other_user = User.find(self.other_user_id)
    following_activity[:other_user_name] = other_user.first_name + " " + other_user.last_name
    following_activity[:other_user_pic] = other_user.profile_pic
    return following_activity
  end

end
