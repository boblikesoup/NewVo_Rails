class API::V1::PostsController < API::V1::ApplicationController
  respond_to :json

  def search

    def post_retrieval(query, used_post_ids)
      if query == "global"
        big_set = Post.all.order('created_at desc').limit(100)
        if used_post_ids.empty?
          return big_set.limit(10)
        else
          return big_set.where("id NOT IN (?)", used_post_ids).limit(10)
        end
      elsif query == "friends"
        friends = []
        current_user.friends.each do |friend|
          friends << friend.id
        end
        big_set = Post.where("user_id = ?", friends).order('created_at desc').limit(100)
        if big_set.empty?
          return big_set.limit(10)
        else
          return big_set.where("id NOT IN (?)", used_post_ids).limit(10)
        end
      elsif query == "following"
        following = []
        current_user.followed_users.each do |followed_user|
          following << followed_user.id
        end
        big_set = Post.where("user_id = ?", following).order('created_at desc').limit(100)
        if big_set.empty?
          return big_set.limit(10)
        else
          return big_set.where("id NOT IN (?)", used_post_ids).limit(10)
        end
      else
        return "Invalid params or already returned all 100 most recent posts."
      end
    end

    used_post_ids = eval(params[:used_post_ids])
    @posts = post_retrieval(params[:query], used_post_ids)
    respond_with(@posts)
  end

  def index
    @post = Post.new
    @posts = Post.order(created_at: :desc)

    2.times { @post.photos.build }
    render json: @posts, :include => [:photos, :comments]
    # respond_with(@posts)
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


  # before_filter :require_user # require_user will set the current_user in controllers
  # ^ in tutorial but not working http://rails-bestpractices.com/posts/47-fetch-current-user-in-models
  before_filter :set_current_user

end