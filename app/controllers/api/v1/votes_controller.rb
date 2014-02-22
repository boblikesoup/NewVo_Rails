class API::V1::VotesController < API::V1::ApplicationController
  # do we want to destroy votes?  right now can't change votes
  respond_to :json

  def create
    if params[:photo]
       current_photo = Photo.find(params[:photo])
       @vote = Vote.new(user_id: @current_user.id, value: params[:value], post_id: current_photo.post_id)
       @post = Post.find(current_photo.post_id)
       current_photo.votes << @vote
       response = {}
       response["success"] = true
       response["data"] = @post
    end
    render json: response
  end
    ##### for voting on comments #####

    #   current_comment = Comment.find(params[:comment])
    #   vote = Vote.new(user_id: current_user.id, value: params[:value], post_id: current_photo.post.id)
    #   post = Post.find(current_comment.post_id)
    #   current_comment.votes << vote

    # if @vote.save
      # VoteActivity.create!(notified_user_id: Post.find(@post).user_id, other_user_id: @vote.user_id, vote_id: @vote.id)
    # else


  def invalid_voting_attempt(message="Seems like something ain't right with your vote")
    render :json=> {:success=>false, :message=>message}, :status=>401
    return
  end

end