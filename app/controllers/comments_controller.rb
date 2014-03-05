class CommentsController < ApplicationController
  respond_to :html, :json

  def create
    post = Post.find(params[:post_id])
    @comment = Comment.new(body: nil, post_id: post.id, user_id: current_user.id)
    post.comments << @comment
    current_user.comments << @comment
    if @comment.save
      CommentActivity.create!(notified_user_id: Post.find(params[:post_id]).user_id, other_user_id: @comment.user_id, comment_id: @comment.id)
    end
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
    if comment.destroy!
      CommentActivity.where(comment_id: params[:id]).update_all(status: CommentActivity::STATUS_UNPUBLISHED)
    end
    respond_with post
  end
end