class PostsController < ApplicationController
  respond_to :html, :json

  def index
    @post = Post.new
    @posts = Post.order(created_at: :desc)
    @posts_page = true
    @profile = false

    2.times { @post.photos.build }
    #render json: @posts, :include => [:photos, :comments]
    respond_with(@posts)
  end

  def create
    @post = Post.new(post_params)
    current_user.posts << post
    post.save
    respond_with @post, :location => posts_path
      # TODO
      # display errors and prevent cookie overflow when content type is not an image
      # handle error when save is not successful
  end

  def show
    @post = Post.find(params[:id])
    respond_with @post
  end


  def destroy
    post = Post.find(params[:id])
    #post.destroy!
    post.update_attributes(status: Post::STATUS_UNPUBLISHED)
    respond_with post, :location => posts_path
  end

  private
  #refactor this shit!
  def post_params
    params.require(:post).permit(:description, photos_attributes: [:id, :photo])
  end
end