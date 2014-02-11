require 'spec_helper'

describe API::V1::CommentsController, type: :controller do
describe "create a comment" do
  let(:user) { FactoryGirl.create(:user)}
  let(:comment) { FactoryGirl.create(:comment)}
  let(:single_post) { FactoryGirl.create(:single_post)}

    it "should be success" do
      comment_create
      response.should be_success
    end

    it "should return status and a post" do
      comment_create
      JSON.parse(response.body).size.should == 2
    end

    it "should return success: true" do
      comment_create
      expect(JSON.parse(response.body)["success"]).to eq(true)
    end

    it "fails without valid credentials" do
      comment_create_fail
      expect(response.status).to eq(401)
    end
  end
end