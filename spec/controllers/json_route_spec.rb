require 'spec_helper'

describe Api::PostsController do
  describe "GET :index" do
    it "should be success" do
      do_get
      response.should be_success
    end

    it "should return list of posts" do
      5.times{ FactoryGirl.create(:post) }
      do_get
      JSON.parse(response.body).size.should == 5
    end

    it "should return id, name and description of each post" do
      post = FactoryGirl.create(:post)
      do_get
      result = JSON.parse(response.body).first
      result['post']['id'].should == post.id
      result['post']['name'].should == post.name
      result['post']['description'].should == post.description
    end

    def do_get
      get :index, :format => :json
    end
  end
end

describe Api::UsersController do
  describe "GET :index" do
      it "should be success" do
        do_get
      response.should be_success
    end

    def do_get
      get :index, :format => :json
    end
  end
end