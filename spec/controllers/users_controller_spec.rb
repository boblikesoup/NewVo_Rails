require 'spec_helper'

describe API::V1::UsersController, type: :controller do
  let(:user) { FactoryGirl.create(:user)}

    it "should be success" do
      user_show
      response.should be_success
    end

    it "should return status and a user" do
      user_show
      JSON.parse(response.body).size.should == 2
    end

    it "fails without valid credentials" do
      user_show_fail
      expect(response.status).to eq(401)
    end

  end
