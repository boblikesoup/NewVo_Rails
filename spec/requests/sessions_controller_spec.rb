require 'spec_helper'

describe API::V1::SessionsController, type: :controller do
describe "Sessions Controller" do
  let(:user1) {FactoryGirl.create(:user)}

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

# get '/auth/mobile', to: 'api/v1/sessions#create'
# get '/signout/mobile', to: 'api/v1/sessions#destroy'