class CommentsController < ApplicationController
  respond_to :html, :json

  #needs test
  def create
    post = Post.find(params[:post_id])
    comment = Comment.new(body: params[:body], post_id: params[:post_id], user_id: current_user.id)
    post.comments << comment
    current_user.comments << comment
    if comment.save
      CommentActivity.create!(notified_user_id: Post.find(params[:post_id]).user_id, other_user_id: comment.user_id, comment_id: comment.id)
    end
    respond_with post
  end

  #needs test
  def update
    comment = Comment.find(params[:id])
    post = Post.find(params[:post_id])
    if comment.body != params[:body]
    comment.update_attributes(body: params[:body])
    comment.save
    respond_with post
    end
  end

  #needs test
  def destroy
    post = Post.find(params[:post_id])
    comment = Comment.find(params[:id])
    if comment.destroy!
      CommentActivity.where(comment_id: params[:id]).update_all(status: CommentActivity::STATUS_UNPUBLISHED)
    end
    respond_with post
  end
end