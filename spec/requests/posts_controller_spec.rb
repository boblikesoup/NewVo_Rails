require 'spec_helper'

describe API::V1::PostsController, type: :controller do
describe "single post controller" do
  let(:user) { FactoryGirl.create(:user)}
  let(:post) { FactoryGirl.create(:single_post)}

    it "should be success" do
      post_show(post)
      response.should be_success
    end

    it "should return status and a post" do
      post_show(post)
      JSON.parse(response.body).size.should == 2
    end

    it "should return success: true" do
      post_show(post)
      expect(JSON.parse(response.body)["success"]).to eq(true)
    end

    it "fails without valid credentials" do
      post_show_fail(post)
      expect(response.status).to eq(401)
    end
  end
end

describe API::V1::PostsController, type: :controller do
describe "double post controller" do
  let(:user) { FactoryGirl.create(:user)}
  let(:post) { FactoryGirl.create(:double_post)}

    it "should be success" do
      post_show(post)
      response.should be_success
    end

    it "should return status and a post" do
      post_show(post)
      JSON.parse(response.body).size.should == 2
    end

    it "should return success: true" do
      post_show(post)
      expect(JSON.parse(response.body)["success"]).to eq(true)
    end

    it "fails without valid credentials" do
      post_show_fail(post)
      expect(response.status).to eq(401)
    end
  end
end


