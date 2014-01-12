class API::V1::CommentsController < ApplicationController
  respond_to :html, :json

  def create
    post = Post.find(params[:post_id])
    comment = Comment.new( comment_params )
    post.comments << comment
    current_user.comments << comment
    comment.save
    respond_with post
  end

  def edit
    @comment = Comment.find(params[:id])
    @post = Post.find(params[:post_id])
    respond_with @post
  end

  def update
    comment = Comment.find(params[:id])
    post = Post.find(params[:post_id])
    comment.update_attributes!( comment_params )
    respond_with post
  end

  def destroy
    post = Post.find(params[:post_id])
    comment = Comment.find(params[:id])
    comment.destroy!
    respond_with post
  end


  private

  def comment_params
    params.require( :comment ).permit( :body )
  end


end