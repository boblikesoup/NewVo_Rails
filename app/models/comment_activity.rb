class CommentActivity < ActiveRecord::Base

  scope :published, ->{where(status: self::STATUS_PUBLISHED)}

  STATUS_PUBLISHED = 0
  STATUS_UNPUBLISHED = 1

  def assemble_json
    comment_activity = {}
    comment_activity[:id] = self.id
    comment_activity[:created_at] = self.created_at
    comment_activity[:other_user] = User.find(self.other_user_id).assemble_user
    comment_activity[:post] = Post.find(Comment.find(self.comment_id).post_id)
    return comment_activity
  end

end
