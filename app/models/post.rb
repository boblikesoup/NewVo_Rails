class Post < ActiveRecord::Base
    belongs_to :user
    has_many :comments, :dependent => :destroy
    has_many :photos, :dependent => :destroy
    has_many :votes, :as => :votable, :dependent => :destroy

    validates_presence_of :title
    validates_presence_of :user_id
end
