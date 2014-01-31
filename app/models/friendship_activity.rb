class FriendshipActivity < ActiveRecord::Base

  scope :published, ->{where(status: self::STATUS_PUBLISHED)}

  STATUS_PUBLISHED = 0
  STATUS_UNPUBLISHED = 1

  def assemble_json
    friendship_activity = {}
    friendship_activity[:id] = self.id
    friendship_activity[:created_at] = self.created_at
    friendship_activity[:other_user] = User.find(self.other_user_id).assemble_user
    return friendship_activity
  end

end
