class Following < ActiveRecord::Base
  validates :follower_id, presence: true
  validates :followed_id, presence: true
end

