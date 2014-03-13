class User < ActiveRecord::Base

  STATUS_PUBLISHED = 0
  STATUS_UNPUBLISHED = 1

  has_many :posts
  has_many :comments
  has_many :votes
  has_many :photos, through: :posts
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, through: :inverse_friendships, :source => :user
  has_many :followed_users, :class_name => 'Following', :foreign_key => 'follower_id'
  has_many :following_users, :class_name => 'Following', :foreign_key => 'followed_id'
  has_many :posts_with_comments, :through => :comments, :source => :post
  has_many :posts_with_votes, :through => :votes, :source => :post
  has_and_belongs_to_many :groups
  #User.followed_users = users User is following
  #User.following_users = users following User

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :fb_uid
  validates_uniqueness_of :fb_uid
  validates_presence_of :newvo_token
  validates_uniqueness_of :newvo_token

  scope :published, ->{where(status: self::STATUS_PUBLISHED)}

  def self.find_or_create_from_auth_hash (auth_hash)
    user = self.find_or_create_by(fb_uid: auth_hash["uid"])
    user.generate_newvo_token
    user.save
    if user
      first_name = auth_hash["info"]["first_name"]
      last_name = auth_hash["info"]["last_name"]
      avatar = auth_hash["info"]["image"]
      facebook_id = auth_hash["uid"]
      user.update_attributes(first_name: first_name, last_name: last_name, profile_pic: avatar, fb_uid: facebook_id)
    end
    user
  end

  def self.find_or_create_from_user_info (user_info, picture_info)
      user = self.find_or_create_by(fb_uid: user_info["id"])
      user.generate_newvo_token
      user.save
      if user
      first_name = user_info["first_name"]
      last_name = user_info["last_name"]
      username = user_info["username"]
      facebook_id = user_info["id"]
      puts "55555555555555555555555555"
      gender = user_info["gender"]
      profile_pic = picture_info["picture"]["data"]["url"]
      user.update_attributes(first_name: first_name, last_name: last_name, fb_uid: facebook_id, profile_pic: profile_pic, facebook_username: username, gender: gender)
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
      :relationship => relationship_status,
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

  def relationship_status
    if Friendship.exists?(user_id: User.current.id, friend_id: self.id)
      return "friend"
    elsif Following.exists?(follower_id: User.current.id, followed_id: self.id)
      return "following"
    elsif User.current.id == self.id
      return "self"
    else
      return "none"
    end

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

# {"id"=>"1765376600", "name"=>"Brent Gaynor", "first_name"=>"Brent", "last_name"=>"Gaynor", "link"=>"https://www.facebook.com/brent.gaynor.1", "work"=>[{"employer"=>{"id"=>"1449626305255785", "name"=>"NewVo"}, "location"=>{"id"=>"114952118516947", "name"=>"San Francisco, California"}, "position"=>{"id"=>"106275566077710", "name"=>"Chief Technology Officer"}, "description"=>"Hustling and programming on a desperate search for the American Dream.  More specifically, jack of all trades at a fashion startup I founded. ", "start_date"=>"2013-12-31"}], "education"=>[{"school"=>{"id"=>"368411969885228", "name"=>"Dev Bootcamp"}, "type"=>"College"}], "gender"=>"male", "timezone"=>-7, "locale"=>"en_US", "verified"=>true, "updated_time"=>"2014-03-10T06:42:05+0000", "username"=>"brent.gaynor.1"}