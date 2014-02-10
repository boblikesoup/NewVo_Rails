require 'spec_helper'
#Need to update tests to validate Type

describe Post do

  it "has a valid factory for single_post" do
    FactoryGirl.create(:single_post)
  end

  it "has a valid factory for double_post" do
    FactoryGirl.create(:double_post)
  end

  it "returns an error without photos" do
      FactoryGirl.build(:single_post, :photos => []).should_not be_valid
  end

  it "should not save without a user_id" do
      FactoryGirl.build(:single_post, :user_id => "").should_not be_valid
  end
end
