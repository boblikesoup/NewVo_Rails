class User < ActiveRecord::Base

  def self.find_or_create_from_auth_hash auth_hash
    user = self.find_or_create_by(fb_uid: auth_hash["uid"])
    if user
      first_name = auth_hash["info"]["first_name"]
      last_name = auth_hash["info"]["last_name"]
      user.update_attributes(first_name: first_name, last_name: last_name)
    end
    user
  end

end