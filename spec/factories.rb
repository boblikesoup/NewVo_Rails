include ActionDispatch::TestProcess

FactoryGirl.define do

    factory :user do
      id 1
      fb_uid "12345"
      first_name "Juke"
      last_name "Aluke"
      newvo_token "OLmeNSbGdgtZEr4nBnRZSYvgc7Hi1hHH"
    end

    factory :user2, class: 'user' do
      id 2
      fb_uid "1765376600"
      first_name "Brent"
      last_name "The Tent"
      newvo_token "67lpujuyKv7jcJpj4x8iYJWKTDta5NwU"
    end

    factory :double_post, class: 'post' do
      description "word"
      user_id 1
      has_single_picture false
      status 0
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
      viewable_by 0
      photos {
      Array(1).sample.times.map do
        FactoryGirl.create(:photo)
      end    }
    end

    factory :single_post_for_vote, class: 'post' do
      id 1
      description "word"
      user_id 1
      has_single_picture true
      status 0
      viewable_by 0
      photos {
      Array(1).sample.times.map do
        FactoryGirl.create(:photo_for_vote)
      end    }
    end

  factory :photo do
    photo { fixture_file_upload(Rails.root.join('spec', 'photos', 'test.jpg'), 'image/jpg') }
  end
  trait :double do
    photo { fixture_file_upload(Rails.root.join('spec', 'photos', 'test2.jpg'), 'image/jpg') }
  end

  factory :photo_for_vote, class: 'photo' do
    id 1
    post_id 1
    photo { fixture_file_upload(Rails.root.join('spec', 'photos', 'test.jpg'), 'image/jpg') }
  end

  factory :comment do
      id 1
      body "They have nothing to look forward to except for the eternal manipulation by forces they never cared to understand"
      user_id 1
      post_id 1
      status 0
  end
  trait :with_activity do
      after :create do |comment|
      FactoryGirl.create_list :comment_activity, 1, :comment_id => comment.id
  end
end

  factory :comment_activity do
      id 1
      notified_user_id 1
      other_user_id 2
      status 0
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
    followed_id 2
  end

  factory :friendship do
    id 1
    user_id 1
    friend_id 2
  end

  factory :group do
    id 1
    user_id 1
    member_ids [1]
    title "The Merry Pranksters"
    description "This is a group of people who like to smile and look pretty"
  end
end