class VotesController < ApplicationController
  def create
    if params[:photo]
      vote = Vote.new(user_id: current_user.id, value: params[:value])
      current_photo = Photo.find(params[:photo])
      current_photo.votes << vote
      vote.save
    end
      redirect_to posts_path
  end


end