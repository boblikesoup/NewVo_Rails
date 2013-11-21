class PostsController < ApplicationController


  def index
    @post = Post.new
    @posts = Post.order(created_at: :desc)
    2.times { @post.photos.build }
  end

  def create
    post = Post.new(post_params)

    current_user.posts << post 
    post.save

    redirect_to posts_path
      # TODO
      # display errors and prevent cookie overflow when content type is not an image
      # handle error when save is not successful

  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end


  def destroy
    post = Post.find(params[:id])
    post.destroy!
    redirect_to posts_path
  end



  private
  #refactor this shit!
  def post_params
    params.require(:post).permit(:title, photos_attributes: [:id, :photo])
  end

  # def post_params_photo
  #   params.require(:post).permit(:photo)
  # end

  # def post_params_photo2
  #   params.require(:post).permit(:photo2)
  # end

end