class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :posts
  has_many :comments
  has_many :votes
  has_many :photos, through: :posts

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

  validates_presence_of :first_name
  validates_presence_of :last_name
  # validates_presence_of :username
  # validates_uniqueness_of :username
  # validates_presence_of :email
  # validates_uniqueness_of :email
  validates_presence_of :fb_uid
  validates_uniqueness_of :fb_uid

  def followed_users
    #to find all current user is following
    followings = []
    Following.where(follower_id: self.id).each do |following|
      followings << following.followed_id
    end
    User.where(id: followings)
  end

  def following_users
    #to find all following current user
    followings = []
    Following.where(followed_id: self.id).each do |following|
      followings << following.follower_id
    end
    User.where(id: followings)
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
    Friendship.create(user_id: self.id, friend_id: followed_id)
    Friendship.create(user_id: followed_id, friend_id: self.id)
  end

  def destroy_friendship(followed_id)
    Friendship.find_by(user_id: self.id, friend_id: followed_id).destroy
    Friendship.find_by(user_id: followed_id, friend_id: self.id).destroy
  end


#Store unique username and email address
  def self.find_or_create_from_auth_hash auth_hash
    user = self.find_or_create_by(fb_uid: auth_hash["uid"])
    if user
      first_name = auth_hash["info"]["first_name"]
      last_name = auth_hash["info"]["last_name"]
      avatar = auth_hash["info"]["image"]
      user.update_attributes(first_name: first_name, last_name: last_name, profile_pic: avatar)
    end
    user
  end

  def self.find_or_create_from_user_info user_info
    user = self.find_or_create_by(fb_uid: user_info["id"])
    if user
      first_name = user_info["info"]["first_name"]
      last_name = user_info["info"]["last_name"]
      avatar = user_info["info"]["image"]
      user.update_attributes(first_name: first_name, last_name: last_name, profile_pic: avatar)
    end
    user
  end

  #To send json of all profile information
  def as_json(options={})
    {
      :first_name => first_name,
      :last_name => last_name,
      :description => description,
      :profile_pic => profile_pic,
      :followed_users => self.followed_users,
      :following_users => self.following_users,
      :friends => self.friends,
      :posts => posts.order("created_at desc").limit(6)
    }
  end

  def self.current
    Thread.current[:user]
  end

  def self.current=(user)
    Thread.current[:user] = user
  end

end

