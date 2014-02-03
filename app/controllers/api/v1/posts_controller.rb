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
        @current_user.friends.recent.not_seen(used_post_ids)
      elsif query == "following"
        @current_user.followed_users.recent.not_seen(used_post_ids)
      else
        return "Invalid params or already returned all 100 most recent posts."
      end
    end

  # test with (Juke db token): curl -s "http://localhost:3000/api/v1/posts/search/?newvo_token=1L6zRtt5SJJ8iZuY0XZ3Xd6StdPOpDkk&used_post_ids=1,2&query=global" | json
  # online test (Juke's) token: OLmeNSbGdgtZEr4nBnRZSYvgc7Hi1hHH

  def search
    if params[:used_post_ids].strip == "[]" || params[:used_post_ids].strip == "" || params[:used_post_ids].blank?
      used_post_ids = []
    else
      used_post_ids = params[:used_post_ids][1..-2].split(',').collect! {|n| n.to_i}
    end
    @posts = post_retrieval(params[:query], used_post_ids)
    dictionary = {}
    dictionary["status"] = "success"
    dictionary["result"] = @posts
    respond_with(dictionary)
  end


#Method that works taking params like used_post_ids = 1,2,3,4
  # def search
  #   if params[:used_post_ids].empty?
  #     used_post_ids = []
  #   else
  #     used_post_ids = params[:used_post_ids].strip.split(',').map(&:strip).map(&:to_i)
  #   end
  #   @posts = post_retrieval(params[:query], used_post_ids)
  #   respond_with(@posts)
  # end

  def index
    @posts = Post.recent
    render json: @posts, :include => [:photos, :comments]
  end

  def create
    post = Post.new(post_params)
    @current_user.posts << post
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
    post.update_attribute(status: Post::STATUS_UNPUBLISHED)
  end

  private
  #refactor this shit!
  def post_params
    params.require(:post).permit(:description, photos_attributes: [:id, :photo])
  end

end