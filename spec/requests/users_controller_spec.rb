require 'spec_helper'

describe API::V1::UsersController, type: :controller do
  let(:user) { FactoryGirl.create(:user)}

    #First four tests are for show route
    it "should be success" do
      params = {}
      params['newvo_token'] = user.newvo_token
      get "/api/v1/users/#{user.id}", params, :format => :json
      response.should be_success
    end

    it "should return status and a user" do
      params = {}
      params['newvo_token'] = user.newvo_token
      get "/api/v1/users/#{user.id}", params, :format => :json
      JSON.parse(response.body).size.should == 2
    end

    it "should return success within the response body" do
      params = {}
      params['newvo_token'] = user.newvo_token
      get "/api/v1/users/#{user.id}", params, :format => :json
      expect(JSON.parse(response.body)["success"]).to eq(true)
    end

    it "fails without valid credentials" do
      params = {}
      get "/api/v1/users/#{user.id}", params, :format => :json
      expect(response.status).to eq(401)
    end

    #Index
    it "returns an index of users" do
      params = {}
      params['newvo_token'] = user.newvo_token
      get "/api/v1/users", params, :format => :json
      expect(JSON.parse(response.body)["success"]).to eq(true)
    end

    #Description
    it "changes the description of a user" do
      params = {}
      params['newvo_token'] = user.newvo_token
      params['description'] = "Tests are fucking fun!"
      patch "/api/v1/users/describe", params, :format => :json
      expect(JSON.parse(response.body)["success"]).to eq(true)
    end

  end

