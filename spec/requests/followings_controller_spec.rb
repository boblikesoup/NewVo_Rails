require 'spec_helper'

describe API::V1::FollowingsController, type: :controller do
describe "Followings Controller" do
  let(:user1) {FactoryGirl.create(:user)}
  let(:user2) {FactoryGirl.create(:user2)}

    #create
    it "should create a following" do
      params = {}
      params['followed_id'] = user2.id
      params['newvo_token'] = user1.newvo_token
      post "/api/v1/followings", params, :format => :json
      expect(JSON.parse(response.body)["success"]).to eq(true)
    end

    #destroy
    it "should delete a following" do
      params = {}
      params['followed_id'] = user2.id
      params['newvo_token'] = user1.newvo_token
      post "/api/v1/followings", params, :format => :json
      delete "/api/v1/followings/#{user2.id}", params, :format => :json
      expect(JSON.parse(response.body)["success"]).to eq(true)
    end
  end
end