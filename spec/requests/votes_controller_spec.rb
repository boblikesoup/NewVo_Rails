require 'spec_helper'

describe API::V1::VotesController, type: :controller do
describe "votes controller" do
  let(:user) {FactoryGirl.create(:user)}
  let(:vote_post) {FactoryGirl.create(:single_post_for_vote)}

    #Create
    it "should create a vote" do
      params = {}
      params['newvo_token'] = user.newvo_token
      params['value'] = 1
      params['photo'] = vote_post.photos[0].id
      post "/api/v1/votes", params, :format => :json
      expect(JSON.parse(response.body)["success"]).to eq(true)
    end
  end
end