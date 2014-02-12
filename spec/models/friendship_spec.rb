require 'spec_helper'

describe Friendship do
  it { should belong_to(:user) }
  it { should belong_to(:friend).class_name('User') }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:friend_id) }

  it "has a valid factory" do
    FactoryGirl.create(:friendship)
  end

end