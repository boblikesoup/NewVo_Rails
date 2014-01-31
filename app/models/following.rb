class Following < ActiveRecord::Base
  belongs_to :user
  belongs_to :following_user, :class_name => 'User'

  validates :follower_id, presence: true
  validates :followed_id, presence: true
end

