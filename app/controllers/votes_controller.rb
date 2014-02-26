class VotesController < ApplicationController
  respond_to :html, :json

  def create
    if params[:photo]
      current_photo = Photo.find(params[:photo])
      vote = Vote.new(user_id: current_user.id, value: params[:value], post_id: current_photo.post_id)
      post = Post.find(current_photo.post_id)
      current_photo.votes << vote
    end
    respond_with post, :location => posts_path
  end

  #for voting on comments
    # else
    #   current_comment = Comment.find(params[:comment])
    #   vote = Vote.new(user_id: current_user.id, value: params[:value], post_id: current_photo.post.id)
    #   post = Post.find(current_comment.post_id)
    #   current_comment.votes << vote

end