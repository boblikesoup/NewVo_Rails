class CommentActivity < ActiveRecord::Base

  scope :published, ->{where(status: self::STATUS_PUBLISHED)}

  STATUS_PUBLISHED = 0
  STATUS_UNPUBLISHED = 1

end
