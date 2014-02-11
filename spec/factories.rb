include ActionDispatch::TestProcess

  # In future, refactor traits for testing associations (post with comments, etc..)
  # trait :with_comments do
  #   after :create do |post|
  #     FactoryGirl.create_list :comment, 3, :post => post
  #   end

FactoryGirl.define do
    factory :user do
      id 1
      fb_uid "12345"
      first_name "Juke"
      last_name "Aluke"
      newvo_token "sYiHGuxbznOwqPuQrMR2tA"
    end

    factory :double_post, class: 'post' do
      description "word"
      user_id 1
      has_single_picture false
      status 0
      global true
      photos {
      Array(2).sample.times.map do
        FactoryGirl.create(:photo)
        FactoryGirl.create(:photo, :double)
      end    }
    end

    factory :single_post, class: 'post' do
      description "word"
      user_id 1
      has_single_picture true
      status 0
      global true
      photos {
      Array(1).sample.times.map do
        FactoryGirl.create(:photo)
      end    }
    end

  factory :photo do
    photo { fixture_file_upload(Rails.root.join('spec', 'photos', 'test.jpg'), 'image/jpg') }
  end
    trait :double do
      photo { fixture_file_upload(Rails.root.join('spec', 'photos', 'test2.jpg'), 'image/jpg') }
  end

  factory :comment do
      id 1
      body "They have nothing to look forward to except for the eternal manipulation by forces they never cared to understand"
      user_id 1
      post_id 1
  end

  factory :vote do
    id 1
    votable_id 1
    user_id 1
    post_id 1
  end

  factory :following do
    id 1
    follower_id 1
    followed_id 1
  end

end