class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :photos
  accepts_nested_attributes_for :photos,
      reject_if: ->(attributes) {attributes[:photo].blank?}

  after_save :update_has_single_picture

  validates_presence_of :user_id
  validates_presence_of :photos
  scope :recent, ->{order(created_at: :desc)}
  scope :published, ->{where(status: self::STATUS_PUBLISHED)}

  STATUS_PUBLISHED = 0
  STATUS_UNPUBLISHED = 1

  def self.not_seen(used_post_ids)
    Post.recent.published.where.not(id: used_post_ids).limit(6)
  end

  def self.not_seen_friends(used_post_ids, user)
    friends = user.friends
    friend_ids = []
    friends.each do |friend|
      friend_ids << friend.id
    end
    Post.recent.published.where.not(id: used_post_ids).where("user_id IN (?)", friend_ids).limit(6)
  end

  def self.not_seen_following(used_post_ids, user)
    followed_relationships = user.followed_users
    followed_user_ids = []
    followed_relationships.each do |relationship|
      followed_user_ids << relationship.followed_id
    end
    Post.recent.published.where.not(id: used_post_ids).where("user_id IN (?)", followed_user_ids).limit(6)
  end

  def as_json(options={})
    {
      :post_id => id,
      :user_id => user_id,
      :profile_pic => User.find(user_id).profile_pic,
      :description => description,
      :has_single_picture => has_single_picture,
      :photos => photos,
      :user_voted => user_voted,
      :comments => comments
    }
  end

  private

  def user_voted
    vote = Vote.find_by(user_id: self.user_id, post_id: self.id)
    if vote != nil
      return true
    else
      return false
    end
  end

  def update_has_single_picture
    self.update_columns(has_single_picture: 'true') if self.photos.count == 1
  end

end