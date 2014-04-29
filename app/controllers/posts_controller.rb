class PostsController < ApplicationController
  respond_to :html, :json

  def index
    @post = Post.new
    @posts = Post.order(created_at: :desc)
    @posts_page = true
    @profile = false
    2.times { @post.photos.build }
    respond_with(@posts)
  end

  def create
    @post = Post.new(post_params)
    current_user.posts << @post
    @post.save
    respond_with @post, :location => posts_path
  end

  def show
    @post = Post.find(params[:id])
    respond_with @post
  end

  def destroy
    @post = Post.find(params[:id])
    @post.update_attributes(status: Post::STATUS_UNPUBLISHED)
    respond_with @post, :location => posts_path
  end

  #api version
  def voted_on
    @posts_voted_on = @current_user.posts_with_votes
    response = {}
    response["success"] = true
    response["posts"] = @posts_voted_on
    render json: response
  end

  #api version
  def not_voted_on
    @posts_not_voted_on = []
    @posts = Post.all.recent.published
    @counter = 0
      until @posts_not_voted_on.count == 20 || @counter == @posts.count do
        @posts.each do |post|
          if post.user_voted? == false
            @posts_not_voted_on << post
          end
          @counter += 1
        end
      end
      if @posts_not_voted_on.count == 0
        response = {}
        response["success"] = false
        response["message"] = "This user has voted on all of the posts in our DB"
        render json: response
      else
        response = {}
        response["success"] = true
        response["recent posts not voted on"] = @posts_not_voted_on
        render json: response
      end
  end

  #api version
  def commented_on
    @posts_commented_on = @current_user.posts_with_comments.uniq
    response = {}
    response["success"] = true
    response["posts"] = @posts_commented_on
    render json: response
  end

  private

  def post_params
    params.require(:post).permit(:description, photos_attributes: [:id, :photo])
  end

end