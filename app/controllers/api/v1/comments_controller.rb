class API::V1::CommentsController < API::V1::ApplicationController
  respond_to :json

  # done
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

  # done
  def update
    @comment = Comment.find(params[:id])
    if @comment.body != params[:body]
    @comment.update_attributes(body: params[:body])
    @comment.save
    response = {}
    response["success"] = true
    response["new_body"] = @comment.body
    response["message"] = "You have successfully changed your comment."
    render json: response
    else
    render json: {success: false, message: "You've tried to update your comment with your current comment. Try again, buddy."}
    end
  end

  # done
  def destroy
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(status: Comment::STATUS_UNPUBLISHED)
      CommentActivity.find_by(comment_id: @comment.id).update_attributes(status: CommentActivity::STATUS_UNPUBLISHED)
    end
    render json: {success: true, message: "comment has been unpublished and should not be displayed"}
  end

  private

  def invalid_comment_attempt(message="Seems like something ain't right with your comment")
    render :json=> {success: false, message: message}, status: 401
  end

end