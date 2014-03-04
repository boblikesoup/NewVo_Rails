require 'spec_helper'

describe API::V1::ActivityFeedController, type: :controller do
describe "activity feed controller routes controller" do
  let(:user) {FactoryGirl.create(:user)}

    #Index
    it "should display an activity feed json" do
      params = {}
      params['newvo_token'] = user.newvo_token
      get "/api/v1/activity_feed", params, :format => :json
      response.should be_success
    end
  end
end