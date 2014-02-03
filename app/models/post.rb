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
      if used_post_ids.empty?
        Post.recent.limit(10)
      else
        Post.recent.where.not(id: used_post_ids).limit(10)
      end
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