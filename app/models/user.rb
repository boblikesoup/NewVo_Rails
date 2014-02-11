class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes
  has_many :photos, through: :posts
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, through: :inverse_friendships, :source => :user

  has_many :followed_users
  has_many :following_users
  #User.followed_users = users User is following
  #User.following_users = users following User
  has_many :followed_users, :class_name => 'Following', :foreign_key => 'follower_id'
  has_many :following_users, :class_name => 'Following', :foreign_key => 'followed_id'


  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :fb_uid
  validates_uniqueness_of :fb_uid

  scope :published, ->{where(status: self::STATUS_PUBLISHED)}

  STATUS_PUBLISHED = 0
  STATUS_UNPUBLISHED = 1


  def following?(followed_id)
    #tells whether current use is following user B
    if Following.exists?(follower_id: self.id, followed_id: followed_id)
      return true
    else
      return false
    end
  end

  def follow!(followed_id)
    if following = Following.create!(follower_id: self.id, followed_id: followed_id)
      #You are now following
      FollowingActivity.create!(notified_user_id: self.id, other_user_id: followed_id, followed_type: "follower", following_id: following.id)
      #Now following you
      FollowingActivity.create!(notified_user_id: followed_id, other_user_id: self.id, followed_type: "followed", following_id: following.id)
    end
  end

#friendships
  def both_following?(followed_id)
    #tells whether two users are following each other
    if User.find(followed_id).following?(self.id) && self.following?(followed_id)
      return true
    else
      return false
    end
  end

  def create_friendship(followed_id)
    if friender = Friendship.create(user_id: self.id, friend_id: followed_id) && friended = Friendship.create(user_id: followed_id, friend_id: self.id)
      FriendshipActivity.create!(notified_user_id: self.id, other_user_id: followed_id, friendship_id: friender.id)
      FriendshipActivity.create!(notified_user_id: followed_id, other_user_id: self.id, friendship_id: friended.id)
    end
  end

  def destroy_friendship(followed_id)
    following = Following.find_by(follower_id: self.id, followed_id: followed_id)
    FollowingActivity.find_by(notified_user_id: self.id, following_id: following.id, followed_type: "follower", status: FollowingActivity::STATUS_PUBLISHED).status = FollowingActivity::STATUS_UNPUBLISHED
    FollowingActivity.find_by(notified_user_id: followed_id, following_id: following.id, followed_type: "followed", status: FollowingActivity::STATUS_PUBLISHED).status = FollowingActivity::STATUS_UNPUBLISHED
    following.destroy
    FriendshipActivity.published.find_by(notified_user_id: self.id, other_user_id: User.find(followed_id)).status = FriendshipActivity::STATUS_UNPUBLISHED
    FriendshipActivity.published.find_by(notified_user_id: User.find(followed_id), other_user_id: self.id).status = FriendshipActivity::STATUS_UNPUBLISHED
    Friendship.find_by(user_id: self.id, friend_id: followed_id).destroy
    Friendship.find_by(user_id: followed_id, friend_id: self.id).destroy
  end

  def self.find_or_create_from_auth_hash auth_hash
    user = self.find_or_create_by(fb_uid: auth_hash["uid"])
    user.generate_newvo_token
    if user
      first_name = auth_hash["info"]["first_name"]
      last_name = auth_hash["info"]["last_name"]
      avatar = auth_hash["info"]["image"]
      facebook_id = auth_hash["uid"]
      user.update_attributes(first_name: first_name, last_name: last_name, profile_pic: avatar, fb_uid: facebook_id)
    end
    user
  end


  # Sign in mobile
  def self.find_or_create_from_user_info (user_info, picture_info)
      user = self.find_or_create_by(fb_uid: user_info["id"])
      user.generate_newvo_token
      if user
      first_name = user_info["first_name"]
      last_name = user_info["last_name"]
      username = user_info["username"]
      facebook_id = user_info["id"]
      profile_pic = picture_info["picture"]["data"]["url"]
      user.update_attributes(first_name: first_name, last_name: last_name, fb_uid: facebook_id, profile_pic: profile_pic, facebook_username: username)
    end
   user
  end

  def generate_newvo_token
    generate_unique_field! :newvo_token, 32 if newvo_token.blank?
    self.save
  end

  def as_json(options={})
    {
      :user_info => self.assemble_user,
      :user_description => description,
      :followed_users => sort_followed(User.where(id: self.followed_users.pluck(:followed_id))),
      :following_users => sort_following(User.where(id: self.following_users.pluck(:follower_id))),
      :friends => sort_friends(self.friends),
      :posts => posts.recent.limit(6)
    }
  end
#called on like .assemble_user (refactor where search by id)
  def assemble_user
    user_hash = {}
    user_hash["id"] = self.id
    user_hash["name"] = self.first_name
    user_hash["profile_pic"] = self.profile_pic
    return user_hash
  end

#using just first name for now
  # def full_name
  #   return self.first_name + " " + self.last_name
  # end


#refactor these into 1 method
  def sort_followed (followed_users)
    user_array = []
    followed_users.each do |followed_user|
      user = followed_user.assemble_user
      user_array << user
    end
    return user_array
  end

  def sort_following (following_users)
    user_array = []
    following_users.each do |following_user|
      user = following_user.assemble_user
      user_array << user
    end
    return user_array
  end

  def sort_friends (friends)
    user_array = []
    friends.each do |friend|
      user = friend.assemble_user
      user_array << user
    end
    return user_array
  end

  def self.current
    Thread.current[:user]
  end

  def self.current=(user)
    raise(ArgumentError,
        "Invalid user. Expected an object of class 'User', got #{user.inspect}") unless user.is_a?(User)
    Thread.current[:user] = user
  end

end