require 'spec_helper'

describe API::V1::SessionsController, type: :controller do
describe "Sessions Controller" do
  let(:user1) {FactoryGirl.create(:user)}

    #create (can't find way to get facebook user access token for testing)
    # it "should create a following" do
    #   params = {}
    #   get "api/v1/auth/mobile", params, :format => :json
    #   expect(JSON.parse(response.body)["success"]).to eq(true)
    # end

    #destroy
    it "should delete a session" do
      params = {}
      params['newvo_token'] = user1.newvo_token
      get "api/v1/signout/mobile", params, :format => :json
      expect(JSON.parse(response.body)["success"]).to eq(true)
    end
  end
end