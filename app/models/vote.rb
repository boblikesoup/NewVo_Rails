class Vote < ActiveRecord::Base
  scope :published, ->{where(status: self::STATUS_PUBLISHED)}

  STATUS_PUBLISHED = 0
  STATUS_UNPUBLISHED = 1

  # Should these not belong to posts as well?
  # belongs_to :post
  belongs_to :user
  belongs_to :votable, polymorphic: true, counter_cache: true

  validates_presence_of :user_id
  validates_presence_of :post_id
  validates_uniqueness_of :user_id, scope: [:votable_id, :votable_type, :value]

  # broken!
  # after_save :destroy_previous_vote

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

  private

  # Method is broken due to the post in this line "if self.votable.post.has_single_picture?"
  # Try a = Vote.create and then a.votable
  # Tests break because votable returns nil and there is no method #post for nil

  # def destroy_previous_vote
  #   if self.votable.post.has_single_picture? or self.votable.is_a?(Comment)
  #     previous_vote = self.votable.votes.where(user_id: self.user_id).take
  #   else
  #     previous_vote = Vote.where(user_id: self.user_id, post_id: self.post_id).take
  #   end
  #     previous_vote.destroy if previous_vote != self
  # end

end