class User < ActiveRecord::Base
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


  # Sign in web
  # Example object on omniauth github page
  def self.find_or_create_from_auth_hash auth_hash
    user = self.find_or_create_by(fb_uid: auth_hash["uid"])
    if user
      user.generate_newvo_token
      first_name = auth_hash["info"]["first_name"]
      last_name = auth_hash["info"]["last_name"]
      avatar = auth_hash["info"]["image"]
      facebook_id = auth_hash["uid"]
      user.update_attributes(first_name: first_name, last_name: last_name, profile_pic: avatar, fb_uid: facebook_id)
    end
    user
  end

  # Sign in mobile
  def self.find_or_create_from_user_info (user_info) #, profile_pic)
      user = self.find_or_create_by(fb_uid: user_info["id"])
      if user
      user.generate_newvo_token
      first_name = user_info["first_name"]
      last_name = user_info["last_name"]
      username = user_info["username"]
      facebook_id = user_info["id"]
      # profile_pic = profile_pic["picture"]["data"]["url"]
      user.update_attributes(first_name: first_name, last_name: last_name, facebook_username: username, fb_uid: facebook_id) #, profile_pic: profile_pic)
    end
   user
  end

  def generate_newvo_token
    generate_unique_field! :newvo_token, 32 if newvo_token.blank?
    self.save
  end

  #To send json of all profile information
  def as_json(options={})
    {
      :id => id,
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

