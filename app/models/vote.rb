class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :votable, polymorphic: true #, counter_cache: true
  validates_uniqueness_of :user_id, scope: [:votable_id, :votable_type, :value]
  after_save :destroy_previous_vote

  private

  def destroy_previous_vote
    if self.votable.post.has_single_picture? or self.votable.is_a?(Comment)
      previous_vote = self.votable.votes.where(user_id: self.user_id).take
    else
      previous_vote = Vote.where(user_id: self.user_id, post_id: self.post_id).take
    end
      previous_vote.destroy if previous_vote != self
  end

  def assemble_vote
    vote = {}
    vote[:value] = self.value
    vote[:photo] = Photo.find(self.votable_id).photo.url(:thumb)
    vote[:post_id] = self.post_id
    return vote
  end

end