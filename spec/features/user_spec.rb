require 'spec_helper'

feature '/auth/facebook' do
before(:each) do
    web_login
  end

describe "When user is logged in", :type => :feature, :js => true do
  it "should allow user to sign in" do
    expect(page).to have_content "Brent"
  end

feature '/posts' do
  it "should be success" do
    visit "/posts"
    #make post here
    expect(page).to have_content "Ask"
  end

  it "should have valid factory" do
    FactoryGirl.build(:user).should be_valid
  end

  it "should require a username" do
    FactoryGirl.build(:user, :first_name => "").should_not be_valid
  end
  # xit "should allow user to respond to post" do
  # end

  # xit "should allow user to upvote a post" do
  # end

  # xit "should allow user to downvote a post" do
  # end

  # xit "should not allow user to upvote the same post more than once" do
  # end

  # xit "should not allow user to downvote the same post more than once" do
  # end

  # xit "should not allow user to upvote the same comment more than once" do
  # end

  # xit "should not allow user to downvote the same comment more than once" do
  # end
end
end
end
