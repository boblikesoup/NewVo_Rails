class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :votable, polymorphic: true #, counter_cache: true
  validates_uniqueness_of :user_id, scope: [:votable_id, :votable_type, :value]
  after_save :destroy_previous_vote
  
  private

  def destroy_previous_vote
    return if !self.votable.post.has_single_picture? or self.votable.is_a?(Comment)
    previous_vote = self.votable.votes.where(user_id: self.user_id).take
    previous_vote.destroy if previous_vote != self
  end
  # TODO
  #need to add validation after save to delete previous votes on 
  # other pics. Preferably add post_id to votes table.
end