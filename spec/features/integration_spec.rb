require 'spec_helper'

describe "Guest can access", :type => :feature do
  it "should allow guest to view post" do
  end

  it "should allow guest to view comments" do
  end

  it "should not allow guest to create new post" do
  end

  it "should not allow guest to create new comment" do
  end

  it "should not allow guest to view private post" do
  end
end

describe "User log in page", :type => :feature do
  let(:info){
    {
      first_name: "John",
      last_name: "Doe",
    }
  }
  let(:uid){ "12345" }

  it "should show the home page with the fb button" do
    visit '/'
    expect(page).to have_content("Log in")
  end

  it "should show welcome page after successful log in" do
    OmniAuth.config.add_mock(:facebook, {:uid => uid, :info => info })
    visit '/'
    click_on 'Log in'
    expect(page).to have_content("Welcome John")
  end
end

describe "When user is logged in", :type => :feature do
  it "should allow user to sign out" do
  end

  it "should allow user to create a post with a picture" do
  end

  it "should allow user to set post as public for anyone to see" do
  end

  it "should allow user to respond to post" do
  end

  it "should allow user to upvote a post" do
  end

  it "should allow user to downvote a post" do
  end

  it "should not allow user to upvote the same post more than once" do
  end

  it "should not allow user to downvote the same post more than once" do
  end

  it "should not allow user to upvote the same comment more than once" do
  end

  it "should not allow user to downvote the same comment more than once" do
  end
end
