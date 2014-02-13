class API::V1::PostsController < API::V1::ApplicationController
  respond_to :json

  # TODO
  # test search
  # have each as own route (gets rid of if statement)

    def post_retrieval(query, used_post_ids)
      if query == "global"
        Post.not_seen(used_post_ids)
      elsif query == "friends"
        Post.not_seen_friends(used_post_ids, @current_user)
      elsif query == "following"
        Post.not_seen_following(used_post_ids, @current_user)
      else
        return "Invalid params or server error."
      end
    end

  # test with (Juke db token): curl -s "http://localhost:3000/api/v1/posts/search/?newvo_token=1L6zRtt5SJJ8iZuY0XZ3Xd6StdPOpDkk&used_post_ids=[1,2]&query=global" | json
  # online test (Juke's) token: newvo.herokuapp.com/api/v1/posts/search/?newvo_token=OLmeNSbGdgtZEr4nBnRZSYvgc7Hi1hHH&used_post_ids=[1,2]&query=global

  def search
    if params[:used_post_ids].strip == "[]" || params[:used_post_ids].strip == "" || params[:used_post_ids].blank?
      used_post_ids = []
    else
      used_post_ids = params[:used_post_ids][1..-2].split(',').collect! {|n| n.to_i}
    end
    @posts = post_retrieval(params[:query], used_post_ids)
    response = {}
    response["success"] = true
    response["data"] = @posts
    respond_with(response)
  end

  def index
    @posts = Post.recent
    render json: @posts, :include => [:photos, :comments]
  end

  # @post.photo = params[:Photo1] if params[:Photo1].present?
  # @post.save if @post.valid?

  def create
    post = Post.new(post_params)
    @current_user.posts << post
    post.save
    respond_with post, :location => api_v1_posts_path
    # TODO
    # display errors and prevent cookie overflow when content type is not an image
    # handle error when save is not successful
  end

  def show
    @post = Post.find(params[:id])
    response = {}
    response["success"] = true
    response["data"] = @post
    respond_with(response)
  end

  def destroy
    post = Post.find(params[:id])
    #post.destroy!
    post.update_attributes(status: Post::STATUS_UNPUBLISHED)
  end

  private
  #refactor this shit!
  def post_params
    params.require(:post).permit(:description, photos_attributes: [:id, :photo])
  end

end