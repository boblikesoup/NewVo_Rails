require 'spec_helper'

describe API::V1::GroupsController, type: :controller do
describe "Groups Controller" do
  let(:user) {FactoryGirl.create(:user)}
  let(:group) {FactoryGirl.create(:group)}

    #create
    it "should create a group" do
      params = {}
      params['newvo_token'] = user.newvo_token
      params['member_ids'] = [1,2,3,4,5]
      params['user_id'] = user.id
      params['title'] = "Knights of the Square Table"
      post "/api/v1/groups", params, :format => :json
      expect(JSON.parse(response.body)["success"]).to eq(true)
    end

    #Show
    it "should show a group" do
      params = {}
      params['newvo_token'] = user.newvo_token
      get "/api/v1/groups/#{group.id}", params, :format => :json
      response.should be_success
    end

    #update
    it "should add members to a group" do
      params = {}
      params['member_ids'] = [2]
      params['newvo_token'] = user.newvo_token
      params['group_id'] = group.id
      patch "/api/v1/groups/add", params, :format => :json
      expect(JSON.parse(response.body)["success"]).to eq(true)
    end

    #destroy
    it "should delete a group" do
      params = {}
      params['newvo_token'] = user.newvo_token
      delete "/api/v1/groups/#{group.id}", params, :format => :json
      expect(JSON.parse(response.body)["success"]).to eq(true)
    end
  end
end