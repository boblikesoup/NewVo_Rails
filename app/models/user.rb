class User < ActiveRecord::Base
  has_many :posts, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :votes, :dependent => :destroy
  has_many :photos, through: :posts

  has_many :followings, foreign_key: "follower_id", dependent: :destroy
  has_many :followings, foreign_key: "followed_id", dependent: :destroy

  has_many :followed_users, through: :followings, source: :followed
  has_many :following_users, through: :followings, source: :follower
  #user.followed_users to find all current user is following
  #user.following_users to find all following current user
  # above functionality of selection is not currently working


  # validates_presence_of :first_name
  # validates_presence_of :last_name
  # validates_presence_of :username
  # validates_uniqueness_of :username
  # validates_presence_of :email
  # validates_uniqueness_of :email
  # validates_presence_of :fb_uid
  # validates_uniqueness_of :fb_uid

  def following?(other_user)
    followings.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    followings.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    followings.find_by_followed_id(other_user.id).destroy
  end

#Store unique username and email address
  def self.find_or_create_from_auth_hash auth_hash
    user = self.find_or_create_by(fb_uid: auth_hash["uid"])
    if user
      first_name = auth_hash["info"]["first_name"]
      last_name = auth_hash["info"]["last_name"]
      user.update_attributes(first_name: first_name, last_name: last_name)
    end
    user
  end

end
