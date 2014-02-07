module CapybaraHelpers

  def login_with_oauth(service = :facebook)
    visit "/auth/#{service}"
  end

  def web_login
    visit root_path
    login_with_oauth
  end

  def photo_create
    photo = FactoryGirl.create(:photo)
    return photo
    #<Photo id: 1, post_id: nil, created_at: "2014-02-04 20:05:22", updated_at: "2014-02-04 20:05:22", photo_file_name: "test.jpg", photo_content_type: "image/jpg", photo_file_size: 37077, photo_updated_at: "2014-02-04 20:05:21">
  end

  def post_show(post)
    params = {}
    params['newvo_token'] = user.newvo_token
    get "/api/v1/posts/#{post.id}", params, :format => :json
    # get :show, :format => :json, :id => post.id, :newvo_token => user.newvo_token
  end

  def user_show
    # params = {}
    # params['newvo_token'] = user.newvo_token
    # get "/api/v1/users/#{user.id}", params, :format => :json
    get :show, :format => :json, :id => user.id, :newvo_token => user.newvo_token
  end

  def user_show_fail
    # params = {}
    # params['newvo_token'] = user.newvo_token
    # get "/api/v1/users/#{user.id}", params, :format => :json
    get :show, :format => :json, :id => user.id
  end

  def post_show_fail(post)
    params = {}
    get "/api/v1/posts/#{post.id}", params, :format => :json
    # get :show, :format => :json, :id => post.id, :newvo_token => user.newvo_token
  end

end