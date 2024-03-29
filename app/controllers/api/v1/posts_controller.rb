class API::V1::PostsController < API::V1::ApplicationController
  respond_to :json

  # done
  def create
    photo1 = Photo.create(photo: params[:photo1])
    post = Post.new(description: params[:description], user_id: @current_user.id, viewable_by: params[:viewable_by])
    post.photos << photo1
    if params.has_key?(:photo2)
      photo2 = Photo.create(photo: params[:photo2])
      post.photos << photo2
    end
    if post.save
      response = {}
      response["success"] = true
      response["data"] = post
      render json: response
    else
      invalid_post_attempt
    end
  end

  # done
  def show
    @post = Post.find(params[:id])
    if @post.status == Post::STATUS_UNPUBLISHED
      render json: {success: false, message: "This post has been deleted."}
    else
      response = {}
      response["success"] = true
      response["data"] = @post
      render json: response
    end
  end

  # done
  def destroy
    post = Post.find(params[:id])
    #post.destroy!
    post.update_attributes(status: Post::STATUS_UNPUBLISHED)
    render json: {success: true, message: "post has been unpublished and should not be displayed"}
  end

  # done
  def index
    @posts = Post.recent
    render json: @posts, :include => [:photos, :comments]
  end

  def voted_on
    @posts_voted_on = @current_user.posts_with_votes
    response = {}
    response["success"] = true
    response["posts"] = @posts_voted_on
    render json: response
  end

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

  def commented_on
    @posts_commented_on = @current_user.posts_with_comments.uniq
    response = {}
    response["success"] = true
    response["posts"] = @posts_commented_on
    render json: response
  end

  private

  def invalid_post_attempt(message="Seems like something ain't right with your post")
    render :json=> {success: false, message: message}, status: 401
    return
  end

end