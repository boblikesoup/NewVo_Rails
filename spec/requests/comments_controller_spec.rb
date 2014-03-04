require 'spec_helper'

describe API::V1::CommentsController, type: :controller do
describe "create a comment" do
  let(:user) { FactoryGirl.create(:user)}
  let(:comment) { FactoryGirl.create(:comment)}
  let(:single_post) { FactoryGirl.create(:single_post)}

    it "should be success" do
      params = {}
      params['body'] = comment.body
      params['newvo_token'] = user.newvo_token
      post "/api/v1/posts/#{single_post.id}/comments", params, :format => :json
      response.should be_success
    end

    it "should return status and a post" do
      params = {}
      params['body'] = comment.body
      params['newvo_token'] = user.newvo_token
      post "/api/v1/posts/#{single_post.id}/comments", params, :format => :json
      JSON.parse(response.body).size.should == 2
    end

    it "should return success: true" do
      params = {}
      params['body'] = comment.body
      params['newvo_token'] = user.newvo_token
      post "/api/v1/posts/#{single_post.id}/comments", params, :format => :json
      expect(JSON.parse(response.body)["success"]).to eq(true)
    end

    it "fails without valid credentials" do
      params = {}
      post "/api/v1/posts/#{single_post.id}/comments", params, :format => :json
      expect(response.status).to eq(401)
    end
  end
end