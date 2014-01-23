module CapybaraHelpers

  def login_with_oauth(service = :facebook)
    visit "/auth/#{service}"
  end

  def web_login
    visit root_path
    login_with_oauth
  end

end