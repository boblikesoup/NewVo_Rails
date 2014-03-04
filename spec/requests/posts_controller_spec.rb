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

    it "should return success: true" do
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

    it "should return success: true" do
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

describe API::V1::PostsController, type: :controller do
describe "post create controller" do
  let(:user) {FactoryGirl.create(:user)}
  let(:photo) {fixture_file_upload(Rails.root.join('spec', 'photos', 'test.jpg'), 'image/jpg')}

    it "should create a post" do
      params = {}
      params['newvo_token'] = user.newvo_token
      params['photo1'] = photo
      params['description'] = "dig this post mother fucker"
      post "/api/v1/posts", params, :format => :json
      expect(JSON.parse(response.body)["success"]).to eq(true)
    end
  end
end

# api_v1_posts GET    /api/v1/posts(.:format)        api/v1/posts#index {:format=>:json}
#              POST   /api/v1/posts(.:format)    api/v1/posts#create {:format=>:json}
#  api_v1_post GET    /api/v1/posts/:id(.:format) api/v1/posts#show {:format=>:json}
#             DELETE /api/v1/posts/:id(.:format)  api/v1/posts#destroy {:format=>:json}

#/Users/apprentice/Documents/brent/newvo/spec/fixtures/Users/apprentice/Documents/brent/newvo/spec/photos/test.jpg

