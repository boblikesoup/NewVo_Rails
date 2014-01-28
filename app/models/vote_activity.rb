class VoteActivity < ActiveRecord::Base

  def assemble_json
    vote_activity = {}
    vote_activity[:created_at] = self.created_at
    vote_activity[:other_user_id] = self.other_user_id
    other_user = User.find(self.other_user_id)
    vote_activity[:other_user_name] = other_user.first_name + " " + other_user.last_name
    vote_activity[:other_user_pic] = other_user.profile_pic
    vote = Vote.find(self.vote_id)
    vote_activity[:value] = vote.value
    vote_activity[:photo] = Photo.find(vote.votable_id).photo.url(:thumb)
    vote_activity[:post_id] = vote.post_id
    return vote_activity
  end

end
