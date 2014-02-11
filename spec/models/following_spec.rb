require 'spec_helper'

describe Following do
  # it { should belong_to(:user) }
  # it { should belong_to(:following_user).class_name('User') }
  it { should validate_presence_of(:follower_id) }
  it { should validate_presence_of(:followed_id) }

  it "has a valid factory" do
    FactoryGirl.create(:following)
  end

end
