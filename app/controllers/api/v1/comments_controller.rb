class API::V1::CommentsController < API::V1::ApplicationController
  respond_to :json

  def create
    @comment = Comment.new(body: params[:body], post_id: params[:post_id], user_id: @current_user.id)
    if @comment.save
      CommentActivity.create!(notified_user_id: Post.find(params[:post_id]).user_id, other_user_id: @comment.user_id, comment_id: @comment.id)
      response = {}
      response["success"] = true
      response["data"] = @comment
      render json: response
    else
      invalid_comment_attempt
    end
  end

  # unfinished
  def edit
    comment = Comment.find(params[:id])
  end

  # unfinished
  def update
    comment = Comment.find(params[:id])
    comment.update_attributes!()
  end

  # unfinished
  def destroy
    comment = Comment.find(params[:id])
    if comment.update_attributes(status: Comment::STATUS_UNPUBLISHED)
      CommentActivity.where(comment_id: params[:id]).update_attributes(status: CommentActivity::STATUS_UNPUBLISHED)
    end
  end

  private

  def invalid_comment_attempt(message="Seems like something ain't right with your comment")
    render :json=> {success: false, message: message}, status: 401
  end

end