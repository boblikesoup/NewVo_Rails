class API::V1::VotesController < ApplicationController
  respond_to :json

  def create
    if params[:photo]
      current_photo = Photo.find(params[:photo])
      vote = Vote.new(user_id: current_user.id, value: params[:value], post_id: current_photo.post.id)
      post = Post.find(current_photo.post_id)
      current_photo.votes << vote
    else
      current_comment = Comment.find(params[:comment])
      vote = Vote.new(user_id: current_user.id, value: params[:value], post_id: current_photo.post.id)
      post = Post.find(current_comment.post_id)
      current_comment.votes << vote
    end
    vote.save
    respond_with post, :location => api_v1_posts_path
  end

end

