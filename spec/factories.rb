FactoryGirl.define do
  factory :user do
    fb_uid "12345"
    username "boblikesoup"
    email "juke@gmail.com"
    first_name "Juke"
    last_name "Aluke"
  end

  factory :post do
    title "title"
    user_id 12345
  end
end
