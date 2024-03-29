require 'spec_helper'

describe Vote do
  it { should belong_to(:user) }
  it { should belong_to(:post) }
  it { should belong_to(:votable) }
  it { should validate_presence_of(:user_id) }
  it { should validate_uniqueness_of(:user_id) }
  it { should validate_presence_of(:post_id) }

  it "has a valid factory" do
    FactoryGirl.create(:vote)
  end

end