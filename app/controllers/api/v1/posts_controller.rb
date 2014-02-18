class API::V1::PostsController < API::V1::ApplicationController
  include ActionDispatch::TestProcess
  respond_to :json

  def create
    ######################
    # functional test
    # photo1 = Photo.create(photo: fixture_file_upload(Rails.root.join('spec', 'photos', 'test2.jpg'), 'image/jpg'))
    # puts photo1
    # photo2 = Photo.create(photo: fixture_file_upload(Rails.root.join('spec', 'photos', 'test2.jpg'), 'image/jpg'))
    # post = Post.new(photos: [photo1, photo2], description: params[:description], user_id: @current_user.id)
    ######################
    # for production
    photo1 = Photo.create(photo: params[:photo1])
    photo2 = Photo.create(photo: params[:photo2])
    post = Post.new(description: params[:description], user_id: @current_user.id)
    post.photos << photo1
    if photo2.present?
      post.photos << photo2
    end
    #######################
    if post.save
      response = {}
      response["success"] = true
      response["data"] = post
      render json: response
    else
      invalid_post_attempt
    end
  end

  # def circuit_params
#   params.require(:circuit).permit(:title, :id, viewable_tasks:[], ... )
# end

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

    # Could this be in the model?
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

  # TODO
  # test search in spec
  # have each as own route (gets rid of if statement)

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

  private

  def invalid_post_attempt(message="Seems like something ain't right with your post")
    render :json=> {success: false, message: message}, status: 401
    return
  end

end