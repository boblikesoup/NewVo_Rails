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
  end

  def double_photo_create
    photo = FactoryGirl.create(:photo, :double)
    return photo
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