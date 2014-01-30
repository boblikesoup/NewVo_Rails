class API::V1::PostsController < API::V1::ApplicationController
  respond_to :json

  # TODO
  # Get shit out of controllers
  # Refactor into scopes? read rails 4 design patterns on scopes.
  # tests using factory girl (possibly factories in factories creating posts and then testing search or something)
  # have each as own route (gets rid of if statement)

    def post_retrieval(query, used_post_ids)
      if query == "global"
        Post.not_seen(used_post_ids)
      elsif query == "friends"
        current_user.friends.recent.not_seen(used_post_ids)
      elsif query == "following"
        current_user.followed_users.recent.not_seen(used_post_ids)
      else
        return "Invalid params or already returned all 100 most recent posts."
      end
    end

  # test with (Juke db token): curl -s "http://localhost:3000/api/v1/posts/search/?newvo_token=K6Nb4m9PqIhajdRbAcgxCKsqdYlBonsi&used_post_ids=1,2&query=global" | json
  # online test (Juke's) token: OLmeNSbGdgtZEr4nBnRZSYvgc7Hi1hHH
  def search
    used_post_ids = params[:used_post_ids].strip.split(',').map(&:strip).map(&:to_i) unless params[:used_post_ids].blank?
    @posts = post_retrieval(params[:query], used_post_ids)
    respond_with(@posts)
  end

  # No need for @post and @posts

  def index
    @posts = Post.recent
    render json: @posts, :include => [:photos, :comments]
  end

  def create
    post = Post.new(post_params)
    current_user.posts << post
    post.save
    respond_with @post, :location => api_v1_posts_path
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
    post.update_attribute(:published, false)
    respond_with post, :location => api_v1_posts_path
  end

  private
  #refactor this shit!
  def post_params
    params.require(:post).permit(:description, photos_attributes: [:id, :photo])
  end

end