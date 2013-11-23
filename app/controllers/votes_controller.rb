class VotesController < ApplicationController
  respond_to :html, :json
  # TODO
  # use metaprogramming!
  def create 
    vote = Vote.new(user_id: current_user.id, value: params[:value])

    if params[:photo]
      current_photo = Photo.find(params[:photo])
      post = Post.find(current_photo.post_id)
      current_photo.votes << vote
    else
      current_comment = Comment.find(params[:comment])
      post = Post.find(current_comment.post_id)
      current_comment.votes << vote
    end
    vote.save
    respond_with post, :location => posts_path 
  end


end