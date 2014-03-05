class API::V1::VotesController < API::V1::ApplicationController
  # do we want to destroy votes?  right now can't change votes
  respond_to :json

  # done
  def create
    if params[:photo]
       current_photo = Photo.find(params[:photo])
       @vote = Vote.new(user_id: @current_user.id, value: params[:value], post_id: current_photo.post_id)
       @post = Post.find(current_photo.post_id)
       current_photo.votes << @vote
       VoteActivity.create!(notified_user_id: Post.find(@post).user_id, other_user_id: @vote.user_id, vote_id: @vote.id)
       response = {}
       response["success"] = true
       response["data"] = @post
    else
      invalid_voting_attempt
    end
    render json: response
  end

  private

  def invalid_voting_attempt(message="Seems like something ain't right with your vote")
    render :json=> {:success=>false, :message=>message}, :status=>401
  end

end