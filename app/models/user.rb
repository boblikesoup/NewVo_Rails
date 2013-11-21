class User < ActiveRecord::Base
  has_many :posts, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :votes, :dependent => :destroy

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :fb_uid
  validates_uniqueness_of :fb_uid

#Store unique username and email address
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
