require 'spec_helper'

describe User do
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:fb_uid) }
  it { should validate_uniqueness_of(:fb_uid) }
  it { should have_many(:votes) }
  it { should have_many(:posts) }
  it { should have_many(:comments) }
  it { should have_many(:photos).through(:posts) }
  it { should have_many(:friendships) }
  it { should have_many(:friends).through(:friendships) }
  it { should have_many(:inverse_friendships) }
  it { should have_many(:inverse_friends).through(:inverse_friendships).source(:user) }
  it { should have_many(:followed_users) }
  it { should have_many(:following_users) }
  it { should have_and_belong_to_many(:groups) }

  it "should have valid factory" do
    FactoryGirl.build(:user).should be_valid
  end

  it "should require a first_name" do
    FactoryGirl.build(:user, :first_name => "").should_not be_valid
  end

end