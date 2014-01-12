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
  end
end
