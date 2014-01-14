class API::V1::PostsController < ApplicationController
  respond_to :json

  def search

    def newest_photos(query)
      if query == "global"
        return Post.find(:all, :order => "created_at desc", :limit => 6)
      elsif query == "friends"
        friends = []
        current_user.friends.each do |friend|
          friends << friend.id
        end
        return Post.where(user_id: friends).order('created_at desc').limit(6)
      elsif query == "following"
        following = []
        current_user.followed_users.each do |followed_user|
          following << followed_user.id
        end
        return Post.where(user_id: following).order('created_at desc').limit(6)
      else
        "error!!!"
      end
    end

    def time_search(query, newest_photo_time, oldest_photo_time)
      if query == "global"
        first_batch = Post.where(created_at: newest_photo_time..Time.now).order('created_at desc').limit(6)
        #code another parameter for letting know whether last query fetched all newest
        #photos. if so start search between last time sent and first time from JSON before
        if first_batch.length < 6
          second_batch = Post.where(created_at: (Time.now - 2.days)..Time.now).order('created_at desc').limit(6 - first_batch.length)
          second_batch.each do |post|
            first_batch << post
          end
        end
        return first_batch
      elsif query == "friends"
        friends = []
        current_user.friends.each do |friend|
          friends << friend.id
        end
        return Post.where(user_id: friends).order('created_at desc').limit(6)
      elsif query == "following"
        following = []
        current_user.followed_users.each do |followed_user|
          following << followed_user.id
        end
        return Post.where(user_id: following).order('created_at desc').limit(6)
      else
        "error!!!"
      end
    end

    params[:query] = "global"
    if params[:newest_photo_time] == nil
      @posts = newest_photos(params[:query])
    else
      @posts = time_search(params[:query], Time.parse(params[:newest_photo_time]), Time.parse(params[:oldest_photo_time]))
    end

    respond_with(@posts)
  end

  def index
    @post = Post.new
    @posts = Post.order(created_at: :desc)

    2.times { @post.photos.build }
    #render json: @posts, :include => [:photos, :comments]
    respond_with(@posts)
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
    @comment = Comment.new
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