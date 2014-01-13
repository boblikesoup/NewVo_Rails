require "open-uri"
class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes
  has_many :photos, through: :posts
  has_attached_file :avatar

  #most of code needed to hard-cod db relationships intead of methods
  # has_many :followings, foreign_key: "follower_id", dependent: :destroy
  # has_many :followings, foreign_key: "followed_id", dependent: :destroy

  # has_many :followed_users, through: :followings, source: :followed
  # has_many :following_users, through: :followings, source: :follower

  has_many :friendships
  has_many :friends, through: :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, through: :inverse_friendships, :source => :user
  #user.friends returns array of all friends

  # validates_presence_of :first_name
  # validates_presence_of :last_name
  # validates_presence_of :username
  # validates_uniqueness_of :username
  # validates_presence_of :email
  # validates_uniqueness_of :email
  # validates_presence_of :fb_uid
  # validates_uniqueness_of :fb_uid






  def followed_users
    #to find all current user is following
    User.joins(:followings).where({"followings.follower_id" => self.id})
  end

  def following_users
    #to find all following current user
    User.joins(:followings).where({"followings.followed_id" => self.id})
  end


  def following?(followed_id)
    #tells whether current use is following user B
    if Following.exists?(follower_id: self.id, followed_id: followed_id)
      return true
    else
      return false
    end
  end

  def follow!(followed_id)
    #creates current user following user B relationship
    Following.create!(follower_id: self.id, followed_id: followed_id)
  end

  def unfollow!(followed_id)
    #creates current user following user B relationship
    Following.find_by(follower_id: self.id, followed_id: followed_id).destroy
  end

#friendships
  def both_following?(followed_id)
    #tells whether two users are following each other
    if User.find(followed_id).following?(self.id)
      return true
    else
      return false
    end
  end

  def create_friendship(followed_id)
    Friendship.create(user_id: current_user.id, friend_id: followed_id)
    Friendship.create(user_id: followed_id, friend_id: current_user.id)
  end

  def destroy_friendship(followed_id)
    Friendship.find_by(user_id: current_user.id, friend_id: followed_id).destroy
    Friendship.find_by(user_id: followed_id, friend_id: current_user.id).destroy
  end


#Store unique username and email address
  def self.find_or_create_from_auth_hash auth_hash
    user = self.find_or_create_by(fb_uid: auth_hash["uid"])
    if user
      first_name = auth_hash["info"]["first_name"]
      last_name = auth_hash["info"]["last_name"]
      avatar = auth_hash["info"]["image"]
      user.update_attributes(first_name: first_name, last_name: last_name, avatar: avatar)
    end
    user
  end

end

# user.avatar_from_facebook('http://graph.facebook.com/#{@user.fb_uid}/picture')
