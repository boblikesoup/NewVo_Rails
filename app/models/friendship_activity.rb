class FriendshipActivity < ActiveRecord::Base

  def assemble_json
    friendship_activity = {}
    friendship_activity[:created_at] = self.created_at
    friendship_activity[:other_user_id] = self.other_user_id
    other_user = User.find(self.other_user_id)
    friendship_activity[:other_user_name] = other_user.first_name + " " + other_user.last_name
    friendship_activity[:other_user_pic] = other_user.profile_pic
    return friendship_activity
  end

end
