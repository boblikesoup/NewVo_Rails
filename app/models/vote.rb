class Vote < ActiveRecord::Base
  scope :published, ->{where(status: self::STATUS_PUBLISHED)}

  STATUS_PUBLISHED = 0
  STATUS_UNPUBLISHED = 1

  belongs_to :post
  belongs_to :user
  belongs_to :votable, polymorphic: true

  validates_presence_of :user_id
  validates_presence_of :post_id
  validates_uniqueness_of :user_id, scope: [:votable_id, :votable_type, :value]

  def as_json(options={})
    {
      :id => id,
      :votable_id => votable_id,
      :user_id => user_id,
      :value => value,
      :post_id => post_id,
      :votable_type => votable_type,
      :photo => Photo.find(self.votable_id).photo.url(:thumb)
    }
  end

end