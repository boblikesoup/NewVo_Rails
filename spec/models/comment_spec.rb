require 'spec_helper'

describe Comment do
  it { should belong_to(:user) }
  it { should belong_to(:post) }
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:post_id) }
  it { should validate_presence_of(:user_id) }

  it "has a valid factory" do
    FactoryGirl.create(:comment)
  end

end