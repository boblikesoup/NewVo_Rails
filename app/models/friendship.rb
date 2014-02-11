class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: "User"

  validates :user_id, presence: true
  validates :user_id, uniqueness: true
  validates :friend_id, presence: true

  # Should a friendship really have many posts?
  # If so, we need a friendship_id in the post object as a foreign key.

  # has_many :posts

end

#at a user's profile add <%= link_to "Add Friend",
#friendships_path(:friend_id => user, :method => :post %>
# http://railscasts.com/episodes/163-self-referential-association