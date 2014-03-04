require 'spec_helper'
include ActionDispatch::TestProcess

# Single Post Show
describe API::V1::PostsController, type: :controller do
describe "single post controller" do
  let(:user) {FactoryGirl.create(:user)}
  let(:post) {FactoryGirl.create(:single_post)}

    it "should be success" do
      params = {}
      params['newvo_token'] = user.newvo_token
      get "/api/v1/posts/#{post.id}", params, :format => :json
      response.should be_success
    end

    it "should return status and a post" do
      params = {}
      params['newvo_token'] = user.newvo_token
      get "/api/v1/posts/#{post.id}", params, :format => :json
      JSON.parse(response.body).size.should == 2
    end

    it "should return success: true in the response body" do
      params = {}
      params['newvo_token'] = user.newvo_token
      get "/api/v1/posts/#{post.id}", params, :format => :json
      expect(JSON.parse(response.body)["success"]).to eq(true)
    end

    it "fails without valid credentials" do
      params = {}
      get "/api/v1/posts/#{post.id}", params, :format => :json
      expect(response.status).to eq(401)
    end
  end
end

# Double Post Show
describe API::V1::PostsController, type: :controller do
describe "double post controller" do
  let(:user) {FactoryGirl.create(:user)}
  let(:post) {FactoryGirl.create(:double_post)}

    it "should be success" do
      params = {}
      params['newvo_token'] = user.newvo_token
      get "/api/v1/posts/#{post.id}", params, :format => :json
      response.should be_success
    end

    it "should return status and a post" do
      params = {}
      params['newvo_token'] = user.newvo_token
      get "/api/v1/posts/#{post.id}", params, :format => :json
      JSON.parse(response.body).size.should == 2
    end

    it "should return success: true within the response body" do
      params = {}
      params['newvo_token'] = user.newvo_token
      get "/api/v1/posts/#{post.id}", params, :format => :json
      expect(JSON.parse(response.body)["success"]).to eq(true)
    end

    it "fails without valid credentials" do
      params = {}
      get "/api/v1/posts/#{post.id}", params, :format => :json
      expect(response.status).to eq(401)
    end
  end
end

# All other routes
describe API::V1::PostsController, type: :controller do
describe "post routes controller" do
  let(:user) {FactoryGirl.create(:user)}
  let(:photo) {fixture_file_upload(Rails.root.join('spec', 'photos', 'test.jpg'), 'image/jpg')}
  let(:single_post) {FactoryGirl.create(:single_post)}

    #Create
    it "should create a post" do
      params = {}
      params['newvo_token'] = user.newvo_token
      params['photo1'] = photo
      params['description'] = "dig this post mother fucker"
      post "/api/v1/posts", params, :format => :json
      expect(JSON.parse(response.body)["success"]).to eq(true)
    end

    #Index
    it "should display an index of posts" do
      params = {}
      params['newvo_token'] = user.newvo_token
      get "/api/v1/posts", params, :format => :json
      response.should be_success
    end

    #Delete
    it "should delete a post" do
      params = {}
      params['newvo_token'] = user.newvo_token
      delete "/api/v1/posts/#{single_post.id}", params, :format => :json
      expect(JSON.parse(response.body)["success"]).to eq(true)
    end

    #Search
    it "should display search results" do
      params = {}
      params['query'] = "global"
      params['used_post_ids'] = "1,2"
      params['newvo_token'] = user.newvo_token
      get "/api/v1/posts/search", params, :format => :json
      response.should be_success
    end

    #Voted_on
    it "should display posts voted on" do
      params = {}
      params['newvo_token'] = user.newvo_token
      get "/api/v1/posts/voted_on", params, :format => :json
      response.should be_success
    end

    #Commented_on
    it "should display posts commented on" do
      params = {}
      params['newvo_token'] = user.newvo_token
      get "/api/v1/posts/commented_on", params, :format => :json
      response.should be_success
    end
  end
end

# api_v1_posts GET    /api/v1/posts(.:format)        api/v1/posts#index {:format=>:json}
#              POST   /api/v1/posts(.:format)    api/v1/posts#create {:format=>:json}
#  api_v1_post GET    /api/v1/posts/:id(.:format) api/v1/posts#show {:format=>:json}
#             DELETE /api/v1/posts/:id(.:format)  api/v1/posts#destroy {:format=>:json}

#/Users/apprentice/Documents/brent/newvo/spec/fixtures/Users/apprentice/Documents/brent/newvo/spec/photos/test.jpg

