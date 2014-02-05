require 'spec_helper'

describe API::V1::PostsController, type: :controller do
  let(:user) { FactoryGirl.create(:user)}

    it "should be success" do
      post_show(stub_post)
      response.should be_success
    end

    it "should return status and a post" do
      post_show(stub_post)
      JSON.parse(response.body).size.should == 2
    end

    it "should return id, name and description of each post" do
      post_show(stub_post)
      expect(JSON.parse(response.body)["success"]).to eq(true)
    end

    it "returns an error when photo is not stubbed" do
      FactoryGirl.build(:post).should_not be_valid
    end

  end


