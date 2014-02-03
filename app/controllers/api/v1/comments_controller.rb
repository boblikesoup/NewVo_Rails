class API::V1::CommentsController < API::V1::ApplicationController
  respond_to :json

  def create
    post = Post.find(params[:post_id])
    comment = Comment.new( comment_params )
    post.comments << comment
    @current_user.comments << comment
    if comment.save
      CommentActivity.create!(notified_user_id: Post.find(post_id).user_id, other_user_id: comment.user_id, comment_id: comment.id)
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    @post = Post.find(params[:post_id])
  end

  def update
    comment = Comment.find(params[:id])
    post = Post.find(params[:post_id])
    comment.update_attributes!( comment_params )
  end

  def destroy
    post = Post.find(params[:post_id])
    comment = Comment.find(params[:id])
    if comment.destroy!
      CommentActivity.where(comment_id: params[:id]).update_all(status: CommentActivity::STATUS_UNPUBLISHED)
    end
  end


  private

  def comment_params
    params.require( :comment ).permit( :body )
  end


end