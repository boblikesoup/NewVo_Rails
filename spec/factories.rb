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
      # photos {[photo_create]}
      # post.photos = photo_create
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
    # photo { fixture_file_upload( 'spec/photos/test.jpg', 'image/jpeg') }
    # photo => File.new(Rails.root + 'spec/photos/test.jpg')
    # photo Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'photos', 'test.jpg'))
    photo { fixture_file_upload(Rails.root.join('spec', 'photos', 'test.jpg'), 'image/jpg') }
    # attachment :photo, "spec/photos/test.jpg"
    # photo File.open("spec/photos/test.jpg")
    # photo stub_paperclip(Photo)
    # Photo.any_instance.stubs(:save_attached_files).returns(true)
    # post_id 1
  end
end

# unsure of associations

# factory :li_line_item_store do
#     association :store, :factory => :li_store
#     association :line_item, :factory => :li_line_item
#   end

# FactoryGirl.define do
#   factory :alert do
#     zipcode { Array.new(3) { FactoryGirl.build(:zipcode) } }
#   end
# end

# attributes_for method generates a hash of attributes instead of a ruby object
# record.reload variables must be reloaded from the database, attributes won't update unless
