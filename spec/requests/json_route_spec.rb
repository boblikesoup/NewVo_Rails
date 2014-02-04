require 'spec_helper'

describe API::V1::PostsController, type: :controller do
  let(:newvo_token) { "sYiHGuxbznOwqPuQrMR2tA"}

  # status 401 (might need posts...)
  describe "GET :show" do
    it "should be success" do
      do_show
      response.should be_success
    end

    # posts can't be blank
    it "should return list of posts" do
      5.times{ FactoryGirl.create(:post) }
      do_show
      JSON.parse(response.body).size.should == 5
    end

    # posts can't be blank
    it "should return id, name and description of each post" do
      post = FactoryGirl.create(:post)
      do_show
      result = JSON.parse(response.body).first
      expect(JSON.parse(response.body)["photo"]).to eq(["can't be blank"])
    end

    def do_show
      get "/api/v1/posts", :format => :json, :newvo_token => newvo_token
    end
  end
end

# describe Api::V1::UsersController do
#   describe "GET :show" do
#       it "should be success" do
#         do_get
#       response.should be_success
#     end

#     def do_get
#       get :show, :format => :json
#     end
#   end
# end