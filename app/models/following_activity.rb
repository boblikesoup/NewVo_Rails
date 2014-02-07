class FollowingActivity < ActiveRecord::Base

  scope :published, ->{where(status: self::STATUS_PUBLISHED)}

  STATUS_PUBLISHED = 0
  STATUS_UNPUBLISHED = 1

  def assemble_json
    following_activity = {}
    following_activity[:id] = self.id
    following_activity[:created_at] = self.created_at
    following_activity[:followed_type] = self.followed_type
    following_activity[:other_user] = User.find(self.other_user_id).assemble_user
    return following_activity
  end

end
