include ActionDispatch::TestProcess

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
  end

  factory :comment do
  end

  factory :user_with_post do
  end

  factory :post_with_comments
  end

  factory :post_with_votes do
  end

end

# attributes_for method generates a hash of attributes instead of a ruby object
# record.reload variables must be reloaded from the database, attributes won't update unless
