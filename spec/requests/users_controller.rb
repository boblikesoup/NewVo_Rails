require 'spec_helper'

describe API::V1::UsersController, type: :controller do
  let(:user) { FactoryGirl.create(:user)}

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

    it "fails without valid credentials" do
      params = {}
      params['newvo_token'] = user.newvo_token
      get "/api/v1/users/#{user.id}", params, :format => :json
      expect(response.status).to eq(401)
    end

  end

