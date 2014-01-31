class VoteActivity < ActiveRecord::Base

  def assemble_json
    vote_activity = {}
    vote_activity[:id] = self.id
    vote_activity[:created_at] = self.created_at
    vote_activity[:other_user] = User.find(self.other_user_id).assemble_user
    vote_activity[:vote_info] = Vote.find(self.vote_id).assemble_vote
    return vote_activity
  end

end
