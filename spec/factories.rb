include ActionDispatch::TestProcess

FactoryGirl.define do
    factory :user do
      id 1
      fb_uid "12345"
      first_name "Juke"
      last_name "Aluke"
      newvo_token "sYiHGuxbznOwqPuQrMR2tA"
    end

    factory :post do
      description "word"
      user_id 1
      has_single_picture true
      status 0
      global true
      after(:create) do |post|
      post.photos << create(:photo, post: post)
    end
  end

  # for photo attachment?
  # password_confirmation "password1"
  #     handle
  #     tags {
  #       Array(10).sample.times.map do
  #         FactoryGirl.create(:tag)
  #       end
  #     }
  #  end

  factory :photo do
    photo { fixture_file_upload(Rails.root.join('spec', 'photos', 'test.jpg'), 'image/jpg') }
    # post_id 1
  end
end

# attributes_for method generates a hash of attributes instead of a ruby object
# record.reload variables must be reloaded from the database, attributes won't update unless
