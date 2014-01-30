class API::V1::VotesController < API::V1::ApplicationController
  respond_to :json

  def create
    if params[:photo]
      current_photo = Photo.find(params[:photo])
      vote = Vote.new(user_id: current_user.id, value: params[:value], post_id: current_photo.post.id)
      current_photo.votes << vote
    #for voting on comments
    # else
    #   current_comment = Comment.find(params[:comment])
    #   vote = Vote.new(user_id: current_user.id, value: params[:value], post_id: current_photo.post.id)
    #   post = Post.find(current_comment.post_id)
    #   current_comment.votes << vote
    end
    if @vote = vote.save
      notified_user_post = Post.find(@vote.post_id)
      notified_user = notified_user_post.user_id
      VoteActivity.create!(notified_user_id: notified_user, other_user_id: @vote.user_id, vote_id: @vote.id)
    end
  end

end
