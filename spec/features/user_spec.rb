require 'spec_helper'

feature 'Login User' do
before(:each) do
    web_login
  end


describe "When user is logged in", :type => :feature, :js => true do
  it "should allow user to sign in" do
    expect(page).to have_content "Brent"
  end

  # xit "should allow user to create a post with a picture" do
  # end

  # xit "should allow user to set post as public for anyone to see" do
  # end

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