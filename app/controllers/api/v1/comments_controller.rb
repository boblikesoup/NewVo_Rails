class API::V1::CommentsController < API::V1::ApplicationController
  respond_to :json

  def create
    @comment = Comment.new(body: params[:body], post_id: params[:post_id], user_id: @current_user.id)
    response = {}
    if @comment.save
      CommentActivity.create!(notified_user_id: Post.find(params[:post_id]).user_id, other_user_id: @comment.user_id, comment_id: @comment.id)
      response["success"] = true
      response["data"] = @comment
    end
    render json: response
  end

  def edit
    comment = Comment.find(params[:id])
    @post = Post.find(params[:post_id])
  end

  def update
    comment = Comment.find(params[:id])
    post = Post.find(params[:post_id])
    comment.update_attributes!(comment_params)
  end

  def destroy
    comment = Comment.find(params[:id])
    if comment.update_attributes(status: Comment::STATUS_UNPUBLISHED)
      CommentActivity.where(comment_id: params[:id]).update_attributes(status: CommentActivity::STATUS_UNPUBLISHED)
    end
  end


  # private

  # def comment_params
  #   params.require(:comment)#.permit( :body )
  # end


end