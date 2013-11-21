class PostsController < ApplicationController


  def index
    @post = Post.new
    @posts = Post.order(created_at: :desc)
  end

  def create
    post = Post.new(params.require(:post).permit(:title))
    photo = Photo.new(params.require(:post).permit(:photo))
    current_user.posts << post 
    post.save
    post.photos << photo
    photo.save
    redirect_to posts_path
      # TODO 
      # display errors and prevent cookie overflow when content type is not an image
      # handle error when save is not successful

  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update_attributes! post_params
    redirect_to posts_path
  end

  def destroy
    post = Post.find(params[:id]).
    post.destroy!
    redirect_to posts_path
  end



  private 

  def post_params
    params.require( :post ).permit!
  end

end