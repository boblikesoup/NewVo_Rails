class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: "User"

  validates :user_id, presence: true
  validates :friend_id, presence: true
end

#at a user's profile add <%= link_to "Add Friend",
#friendships_path(:friend_id => user, :method => :post %>
# http://railscasts.com/episodes/163-self-referential-association