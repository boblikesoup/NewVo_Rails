require 'spec_helper'
#Need to update tests to validate Type

describe Post do

  it "has a valid factory" do
    FactoryGirl.create(:post)
  end

  it "returns an error without photos" do
      FactoryGirl.build(:post, :photos => []).should_not be_valid
  end

  it "should not save without a user_id" do
      FactoryGirl.build(:post, :user_id => "").should_not be_valid
  end
end
