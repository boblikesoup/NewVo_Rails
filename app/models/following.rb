class Following < ActiveRecord::Base

  # Not accurate information (no user_id and no following_user_id)
  # belongs_to :user
  # belongs_to :following_user, :class_name => 'User'

  validates :follower_id, presence: true
  validates :followed_id, presence: true
end

