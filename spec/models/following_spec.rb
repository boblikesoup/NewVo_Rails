require 'spec_helper'

describe Following do
  it { should validate_presence_of(:follower_id) }
  it { should validate_presence_of(:followed_id) }
  it { should have_db_index(:follower_id) }
  it { should have_db_index(:followed_id) }

  it "has a valid factory" do
    FactoryGirl.create(:following)
  end

end
