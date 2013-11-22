class VotesController < ApplicationController
  def create
    # need to delete previous user vote on the backend so they are able
    # to upvote, 
    vote = Vote.new(user_id: current_user.id, value: params[:value])
    if params[:photo]
      current_photo = Photo.find(params[:photo])
      current_photo.votes << vote
      vote.save
    else
      current_comment = Comment.find(params[:comment])
      current_comment.votes << vote
      vote.save
    end
      redirect_to posts_path
  end


end