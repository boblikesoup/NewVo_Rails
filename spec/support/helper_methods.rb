module CapybaraHelpers

  def login_with_oauth(service = :facebook)
    visit "/auth/#{service}"
  end

  def web_login
    visit root_path
    login_with_oauth
  end

  def photo_create
    photo = FactoryGirl.create(:photo)
    return photo
  end

  def double_photo_create
    photo = FactoryGirl.create(:photo, :double)
    return photo
  end

end