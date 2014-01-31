class FriendshipActivity < ActiveRecord::Base

  def assemble_json
    friendship_activity = {}
    friendship_activity[:id] = self.id
    friendship_activity[:created_at] = self.created_at
    friendship_activity[:other_user] = User.find(self.other_user_id).assemble_user
    return friendship_activity
  end

end
