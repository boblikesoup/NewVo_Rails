require 'spec_helper'

feature 'login' do

describe "When user is logged in", :type => :feature, :js => true do
  it "should allow user to sign in" do
    web_login
    expect(page).to have_content "Brent"
  end

  it "should be success" do
     visit '/posts'
    #make post here
    expect(page).to have_content "Ask"
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

