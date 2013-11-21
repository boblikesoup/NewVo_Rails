class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :dependent => :destroy
  has_many :photos, :dependent => :destroy
  has_many :votes, :as => :votable, :dependent => :destroy

  #Need to change Type to Multiple? T/F
  validates_presence_of :user_id
  # validates_presence_of :type
  validates_presence_of :title
end
