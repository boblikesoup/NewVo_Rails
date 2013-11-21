FactoryGirl.define do
  factory :user do
    fb_uid "12345"
    first_name "Juke"
    last_name "Aluke"
  end

  factory :post do
    title "word"
    user_id 1
  end

end
