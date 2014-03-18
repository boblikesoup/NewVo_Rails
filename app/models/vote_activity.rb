class VoteActivity < ActiveRecord::Base

  scope :published, ->{where(status: self::STATUS_PUBLISHED)}

  STATUS_PUBLISHED = 0
  STATUS_UNPUBLISHED = 1

  def assemble_json
    vote_activity = {}
    vote_activity[:id] = self.id
    vote_activity[:created_at] = self.created_at
    vote_activity[:other_user] = User.find(self.other_user_id).assemble_user
    vote_activity[:vote_info] = Vote.find(self.vote_id)
    vote_activity[:picture_urls] =
    return vote_activity
  end

end
