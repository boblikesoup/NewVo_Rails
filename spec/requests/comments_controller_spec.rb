require 'spec_helper'

describe API::V1::CommentsController, type: :controller do
describe "Comments Controller" do
  let(:user) { FactoryGirl.create(:user)}
  let(:single_post) { FactoryGirl.create(:single_post)}
  let(:comment) { FactoryGirl.create(:comment, :with_activity)}

    #first four tests are comment create
    it "should be success" do
      params = {}
      params['body'] = "fuckall"
      params['newvo_token'] = user.newvo_token
      post "/api/v1/posts/#{single_post.id}/comments", params, :format => :json
      response.should be_success
    end

    it "should return status and a post" do
      params = {}
      params['body'] = "fuckall"
      params['newvo_token'] = user.newvo_token
      post "/api/v1/posts/#{single_post.id}/comments", params, :format => :json
      JSON.parse(response.body).size.should == 2
    end

    it "should return success: true within response body" do
      params = {}
      params['body'] = "fuckall"
      params['newvo_token'] = user.newvo_token
      post "/api/v1/posts/#{single_post.id}/comments", params, :format => :json
      expect(JSON.parse(response.body)["success"]).to eq(true)
    end

    it "should fail without valid credentials" do
      params = {}
      post "/api/v1/posts/#{single_post.id}/comments", params, :format => :json
      expect(response.status).to eq(401)
    end

    #update body
    it "should update a comment" do
      params = {}
      params['body'] = "This is the new body, you silly goose. Speed up or be left behind."
      params['newvo_token'] = user.newvo_token
      patch "/api/v1/posts/#{single_post.id}/comments/#{comment.id}", params, :format => :json
      expect(JSON.parse(response.body)["success"]).to eq(true)
    end

    #destroy
    it "should delete a comment" do
      params = {}
      params['newvo_token'] = user.newvo_token
      delete "/api/v1/posts/#{single_post.id}/comments/#{comment.id}", params, :format => :json
      expect(JSON.parse(response.body)["success"]).to eq(true)
    end
  end
end