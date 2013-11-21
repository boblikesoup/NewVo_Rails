require 'spec_helper'
#Need to update tests to validate Type
#Need tests for dependent destruction of comments, photos, votes

describe Post do
  let(:post_template) { build(:post) }
  let(:post) { create(:post) }

  it "should save with valid attributes" do
    expect {
      post
    }.to change{Post.count}.from(0).to(1)
  end

  it "should not save without a title" do
    expect{
            post_template.title = ""
            post_template.save
    }.to change{Post.count}.by(0)
  end

  it "should not save without a user_id" do
    expect{
            post_template.user_id = ""
            post_template.save
    }.to change{Post.count}.by(0)
  end
end
