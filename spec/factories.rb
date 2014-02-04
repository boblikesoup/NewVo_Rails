include ActionDispatch::TestProcess

FactoryGirl.define do
    factory :user do
      fb_uid "12345"
      username "boblikesoup"
      email "juke@gmail.com"
      first_name "Juke"
      last_name "Aluke"
      single true
    end

    factory :post do
      description "word"
      user_id 1
      has_single_picture true
      status 0
      global true
      after(:create) do |post|
      create(:photo, post: post)
      # #photo { FactoryGirl.build(:photo) }
    end
  end

  # FactoryGirl.define do
  #   factory :image do
  #     title "Example image"
  #     file { fixture_file_upload("files/example.jpg", "image/jpeg") }
  #   end
  # end

  factory :photo do
    # photo { fixture_file_upload( 'spec/photos/test.jpg', 'image/jpeg') }
    # photo => File.new(Rails.root + 'spec/photos/test.jpg')
    # photo Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'photos', 'test.jpg'))
    photo { fixture_file_upload(Rails.root.join('spec', 'photos', 'test.jpg'), 'image/jpg') }
    post_id 1
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
