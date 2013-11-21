require 'spec_helper'
#Need to store unique username and email address
#Needs tests for comment and vote destruction
#Need test for find_or_create... method
#Need to handle account deactivation effects on username appearance and publish status of children

describe User do
  let(:user_template) { build(:user) }
  let(:user) { create(:user) }

  it "should save with valid attributes" do
    expect {
      user
    }.to change{User.count}.from(0).to(1)
  end

  it "should not save without a first_name" do
    expect{
            user_template.first_name = ""
            user_template.save
    }.to change{User.count}.by(0)
  end

  it "should not save without a last_name" do
    expect{
            user_template.last_name = ""
            user_template.save
    }.to change{User.count}.by(0)
  end

  it "should not save without a fb_uid" do
    expect{
            user_template.fb_uid = ""
            user_template.save
    }.to change{User.count}.by(0)
  end

  it "should have a unique insta_id" do
    user
    expect {
      User.create(fb_uid: "12345", first_name: "Juke", last_name: "Aluke", username: "word", email: "new@gmail.com")
    }.to change{User.count}.by(0)
  end

<<<<<<< HEAD
  it "should not save without a username" do
    expect{
            user_template.username = ""
            user_template.save
    }.to change{User.count}.by(0)
  end

  it "should have a unique username" do
    user
    expect {
      User.create(fb_uid: "12345", first_name: "Juke", last_name: "Aluke", username: "boblikesoup", email: "new@gmail.com")
    }.to change{User.count}.by(0)
  end

  it "should not save without an email" do
    expect{
            user_template.email = ""
            user_template.save
    }.to change{User.count}.by(0)
  end

  it "should have a unique email" do
    user
    expect {
      User.create(fb_uid: "12345", first_name: "Juke", last_name: "Aluke", username: "word", email: "juke@gmail.com")
    }.to change{User.count}.by(0)
  end


  it "should destroy dependent posts when deleted" do
    expect {
      new_user = user
      new_post = build(:post)
      new_post.user_id = new_user.id
      new_post.save
      new_user.destroy
    }.to change{Post.count}.by(0)
  end

=======
  it "should destroy posts if destroyed" do
    expect{
            x = user
            post = build(:post)
            post.id = x.id
            post.save
            x.destroy
    }.to change{Post.count}.by(0)
  end
>>>>>>> 645bcdb8755fb334ab738c3da034f5bdb8a8f3d5
end
