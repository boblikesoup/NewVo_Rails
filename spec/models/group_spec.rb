require 'spec_helper'

describe Group do
  it { should have_and_belong_to_many(:users) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:member_ids) }
  it { should validate_presence_of(:title) }
  it "should have valid factory" do
    FactoryGirl.build(:group).should be_valid
  end

  it "should require a first_name" do
    FactoryGirl.build(:group, :title => "").should_not be_valid
  end
end
