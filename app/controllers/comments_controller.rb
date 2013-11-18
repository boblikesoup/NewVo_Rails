class CommentsController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    comment = Comment.new( comment_params )
    post.comments << comment
    current_user.comments << comment

    if comment.save
      redirect_to post
    else
      flash[:error] = comment.errors
      redirect_to post
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    @post = Post.find(params[:post_id])
  end

  def update
    @comment = Comment.find(params[:id])
    post = Post.find(params[:post_id])
    @comment.update_attributes!( comment_params )
    redirect_to post
  end


  private

  def comment_params
    params.require( :comment ).permit( :body )
  end


end